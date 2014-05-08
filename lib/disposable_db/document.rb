module DisposableDB
  class Document
    include Format

    DEFAULT_DELIMITER = ','

    attr_accessor :io, :options, :db
    attr_writer :header

    def initialize(io, options = {})
      @io = io
      @options = options
      @compression = @options[:compression]
      set_quotes(@options.has_key?(:quotes) ? @options[:quotes] : :double)
      set_delimiter(@options[:delimiter] || DEFAULT_DELIMITER)
    end

    def header
      @header || self.parse_header
    end

    def column_names
      @column_names ||= self.header.collect { |c| c.underscore.to_sym }
    end

    def to_sqlite(path)
      return @db if @db

      @db = Sequel.sqlite path

      new_columns = self.column_names

      @db.create_table :document do
        primary_key :id
        column :line_number, Integer
        new_columns.each do |c|
          column c.to_sym, String
        end
      end

      @db.transaction do
        self.parse_body do |values, line_number|
          @db[:document].insert value_map(self.column_names, values).merge!(:line_number => line_number)
        end
      end

      @db
    end

    def parse_header
      @io.rewind
      @header = parse_line(@io.gets.strip!, :delimiter => delimiter, :quotes => quotes)
      set_number_of_fields @header.length
      @header
    end

    def parse_body(&blk)
      @io.rewind
      @io.gets

      i = 0
      while line = @io.gets
        blk.call(parse_line(line.strip!, :quotes => quotes, :number_of_fields => number_of_fields), i)
        i += 1
      end
    end

    def parse
      raise NotImplementedError
      self.parse_header
      self.parse_body
    end

  end
end
