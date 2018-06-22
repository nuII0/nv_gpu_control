require 'forwardable'

module NvGpuControl
  module Util
    class StdoutLogger
      extend Forwardable

      def initialize(level: :info)
        Logging.logger.root.appenders = Logging.appenders.stdout
        Logging.logger.root.level = :info
      end

      def_delegators Logging.logger, :[]
    end
  end
end
