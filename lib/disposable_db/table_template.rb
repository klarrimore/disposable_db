module DisposableDB
  class TableTemplate
    attr_accessor :name, :columns, :primary_key

    def initialize(name, columns = [])
      @name = name
      @columns = columns
      @indexes = indexes
    end

    def add_column(column)
      @columns << column
    end

    def set_primary_key(pk)
      @primary_key = pk
    end

    def indexes
      @columns.select{ |c| c.indexed == true }.collect{ |c| c.name }
    end

    class Column
      attr_accessor :name, :type, :indexed

      def self.types
        # [String, Integer, Fixnum, Bignum, Float, Numeric, BigDecimal, Date, DateTime, Time, File, TrueClass, FalseClass]
        #types = Sequel::Schema::Generator::GENERIC_TYPES

        #name ? types.select { |t| t.name == name }.first : types
        Sequel::Schema::Generator::GENERIC_TYPES
      end

      def initialize(name, type, options = {})
        @name = name
        @type = type
        @indexed = options[:indexed] || false
      end

    end

  end
end
