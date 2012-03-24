require File.expand_path("../bench_helper", __FILE__)

def create_columns(n = 100)
  columns = []
  n.times do |i|
    columns << TableTemplate::Column.new("field_#{i}", String)
  end
  columns
end

def create_database(table_template)
  database = Databases::SQLite.new(:connection_string => 'sqlite://tmp/benchmark.db')
  #database = Databases::SQLite.new
  database.create_table! table_template
  database
end

def create_model
  columns = create_columns

  tt = TableTemplate.new('benchmark', columns)

  database = create_database tt

  DisposableModel.factory(:database => database, :table_name => tt.name)
end

n = 10000
batch = []
Benchmark.bm(30) do |x|
  m = create_model
  x.report("generating random data:")   { n.times { generate_random_data(m.columns) } }

  m = create_model
  cols = m.columns
  batch = []
  v = generate_random_data(cols)
  result = RubyProf.profile do
  #x.report("imports with transaction:") do
    n.times do |i|
      batch << v.values
      if batch.length >= 1000
        m.import(cols, batch)
        batch = []
      end
    end
    m.import(cols, batch) unless batch.length < 1
  #end
  end

  printer = RubyProf::GraphPrinter.new(result)
  printer.print(STDOUT, {})

  exit


# Print a graph profile to text
  printer = RubyProf::GraphPrinter.new(result)
  printer.print(STDOUT, {})

  m = create_model
  x.report("single inserts with transaction:") { m.transaction { n.times { m.insert(generate_random_data(m.columns)) } } }

  m = create_model
  v = generate_random_data(m.columns)
  x.report("single inserts:") { n.times { m.insert(v) } }

  m = create_model
  h = {}
  m.columns.each { |c| h[c] = :"$new_#{c.to_s}" }
  p = m.dataset.prepare(:insert, :insert_all_columns, h)
  v = generate_random_data(m.columns, "new_")
  x.report("prepared single inserts:") do
    n.times do
      p.call(v)
    end
  end

  m = create_model
  x.report("single inserts with transaction:") { m.transaction { n.times { m.insert(generate_random_data(m.columns)) } } }

  m = create_model
  v = generate_random_data(m.columns)
  x.report("multi inserts with transaction:") do
    m.transaction do
      n.times do
        batch build_batch(batch, m.columns, v)
        if batch.length >= 100
          m.import(m.columns, batch)
          batch = []
        end
      end
      m.multi_insert(batch) unless batch.empty?
    end
  end
end