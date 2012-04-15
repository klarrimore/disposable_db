module DisposableDB
  module Databases
    class SQLite < Database

      def initialize(args = {})
        if args[:connection]
          connection = args[:connection]
        elsif args[:db_path]
          connection = Sequel.sqlite args[:db_path]
        end

        super(connection)
      end

    end
  end
end
