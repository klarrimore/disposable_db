module DisposableDB
  module Format
    include Parser

    attr_reader :delimiter, :quotes, :number_of_fields

    def set_delimiter(delimiter)
      @delimiter = delimiter
      create_splitters @delimiter
    end

    def set_quotes(quotes)
      @quotes = quotes
    end

    def set_number_of_fields(number_of_fields)
      @number_of_fields = number_of_fields
    end

    def value_map(columns, values)
      map = {}

      columns.each_with_index { |c,i| map[c] = values[i] }

      map
    end

  end
end
