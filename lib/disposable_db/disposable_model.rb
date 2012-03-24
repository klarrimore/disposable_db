module DisposableDB
  class DisposableModel

    class << self
      def build(database, table_name)

        m = Class.new(Sequel::Model(database.connection)) do
              set_dataset table_name.to_sym

              def self.database
                @database
              end

              def self.database=(d)
                @database = d
              end

              def self.transaction(opts = {}, &block)
                self.database.connection.transaction opts, &block
              end
            end

        m.database = database

        m
      end

    end

    def DisposableModel.factory(args = {})
      database = args[:database] || Database.new
      table_name = args[:table_name] || 'disposable_table'
      build(database, table_name)
    end
  end
end