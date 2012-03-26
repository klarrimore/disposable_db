module DisposableDB
  class Database
    attr_accessor :connection

    def initialize(args = {})
      @connection = args[:connection] || Sequel.sqlite
    end

    def create_table!(table_template)
      @connection.create_table! table_template.name.to_sym do
        table_template.columns.each do |column|
          column column.name.to_sym, column.type
        end
      end
    end

    def create_table(table_template)
      @connection.create_table? table_template.name.to_sym do
        table_template.columns.each do |column|
          column column.name.to_sym, column.type
        end
      end
    end

    def table_exists?(name)
      @connection.table_exists? name
    end

  end
end