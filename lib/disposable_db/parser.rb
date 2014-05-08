module DisposableDB
  module Parser

    QUOTES = :double

    attr_reader :splitter, :fast_split_regexp, :slow_split_regexp

    def create_splitters(delimiter)
      @splitter = delimiter
      @fast_split_regexp = Regexp.new("#{delimiter}(?!(?:[^\"#{delimiter}]|[^\"]#{delimiter}[^\"])+\")")
      @slow_split_regexp = Regexp.new("#{delimiter}(?=(?:[^\"]*\"[^\"]*\")*(?![^\"]*\"))")
    end

    def parse_line(line, options = {})
      values = []

      quotes = options[:quotes] || QUOTES
      number_of_fields = options[:number_of_fields]

      if line && quotes == :double
        values = line.split(@splitter, -1)

        if number_of_fields && values.length != number_of_fields
          values = line.split(@fast_split_regexp, -1)
        end

        if number_of_fields && values.length != number_of_fields
          values = line.split(@slow_split_regexp, -1)
        end

        values.map! { |v| v.sub!(/^"{1}/, '');v.sub!(/"{1}$/, '');v }
      elsif line
        values = line.split(@splitter, -1)
      end

      values
    end

  end
end
