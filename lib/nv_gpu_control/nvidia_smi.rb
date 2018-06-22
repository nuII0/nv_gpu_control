require_relative 'util/shell'

module NvGpuControl
  class NvidiaSmi
    extend Loggable
    extend Util::Shell

    class << self
      BINARY = "nvidia-smi"
      def run(*args)
        raise RuntimeError, "#{BINARY} is not available on the system" unless command?(BINARY)
        `#{[BINARY, *args].shelljoin}`
      end
    end
  end
end
