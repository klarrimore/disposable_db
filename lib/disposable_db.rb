require 'logger'
require 'tempfile'
require 'sequel'
require 'disposable_db/disposable_model'
require 'disposable_db/database'
require 'disposable_db/databases/sqlite'

module DisposableDB
  class << self

    def options
      @options ||= {
        :log => true
      }
    end
  
    def log(message)
      logger.info("[disposable_db] #{message}") if logging?
    end

    def logger
      @logger ||= options[:logger] || Logger.new(STDOUT)
    end

    def logger=(logger)
      @logger = logger
    end

    def logging?
      options[:log]
    end

    class DisposableDBError < StandardError #:nodoc:
    end

  end
end
