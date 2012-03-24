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

n = 100000
batch = []
Benchmark.bm(30) do |x|
  m = create_model
  x.report("generating random data:")   { n.times { generate_random_data(m.columns) } }

  m = create_model
  x.report("single inserts:") { n.times { m.insert(generate_random_data(m.columns)) } }

  m = create_model
  h = {}
  m.columns.each { |c| h[c] = :"$new_#{c.to_s}" }
  p = m.dataset.prepare(:insert, :insert_all_columns, h)
  x.report("prepared single inserts:") do
    n.times do
      p.call(generate_random_data(m.columns, "new_"))
    end
  end

  m = create_model
  x.report("single inserts with transaction:") { m.transaction { n.times { m.insert(generate_random_data(m.columns)) } } }

  m = create_model
  x.report("multi inserts with transaction:") do
    m.transaction do
      n.times do
        batch << generate_random_data(m.columns)
        if batch.length >= 10
          m.multi_insert(batch)
          batch = []
        end
      end
      m.multi_insert(batch) unless batch.empty?
    end
  end
end