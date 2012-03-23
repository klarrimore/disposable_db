module DisposableDB::Databases
  class Database
    attr_accessor :connection

    def initialize(args = {})
      @connection = args[:connection]
    end

  end
end