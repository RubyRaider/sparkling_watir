require 'forwardable'
require 'logger'

module SparklingWatir
  module Logger
    #
    # @example Use logger manually
    #   SparklingWatir::Logger.debug('This is info message')
    #   SparklingWatir::Logger.warn('This is warning message')
    #
    class << self
      extend Forwardable
      def_delegators :logger, :fatal, :error, :warn, :info, :debug, :level, :level=, :formatter, :formatter=

      attr_writer :logger

      private

      def logger
        @logger ||= begin
                      logger = ::Logger.new($stdout)
                      logger.progname = 'sparkling_watir'
                      logger.level = ::Logger::WARN
                      logger.formatter = proc { |_severity, _datetime, _progname, msg| "#{msg}\n" }
                      logger
                    end
      end
    end # class << self
  end # module Logger
end # module SparklingWatir