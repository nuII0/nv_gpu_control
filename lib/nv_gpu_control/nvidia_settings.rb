require_relative 'util/shell'

module NvGpuControl
  class NvidiaSettings
    extend Loggable
    extend Util::Shell

    class << self
      BINARY = "nvidia-settings"
      DISPLAY = ENV['DISPLAY'] || ':0'
      def run(*args)
        raise RuntimeError, "#{BINARY} is not available on the system" unless command?(BINARY)
        `DISPLAY=#{DISPLAY} #{[BINARY, *args].shelljoin}`
      end
    end
  end
end
