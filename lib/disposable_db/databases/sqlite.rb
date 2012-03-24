module DisposableDB
  module Databases
    class SQLite < Database

      def intialize(args = {})
        unless args.has_key? :connection
          if args[:connection_string]
            args[:connection] = Sequel.sqlite(args[:connection_string])
          end
        end

        super(args)
      end

    end
  end
end