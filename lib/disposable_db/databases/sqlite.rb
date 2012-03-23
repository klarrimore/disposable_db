module DisposableDB::Databases
  class SQLite < Database

    def intialize(args = {})
      args[:connection] ||= Sequel.sqlite(args[:connection_string])
      super(args)
    end

  end
end