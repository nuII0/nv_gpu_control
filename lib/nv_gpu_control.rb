require 'logging'
require 'shellwords'

module NvGpuControl
  require_relative "nv_gpu_control/loggable"
  require_relative "nv_gpu_control/util/stdout_logger"

  require_relative "nv_gpu_control/nvidia_smi"
  require_relative "nv_gpu_control/nvidia_gpu"

  @logger = Util::StdoutLogger.new
  class << self
    attr_accessor :logger

    # @return [Array<NvidiaGpu>] installed GPUs on the system.
    def gpus
      NvidiaSmi.run("-L").lines.map do |line|
        match = line.match(/(.*): (.*) \(UUID: (.*)\)/)
        raise RuntimeError, "Unable to parse GPU from SMI Output. Output was: #{line}" unless match
        index = match[1].to_i
        name = match[2]
        uuid = match[3]

        NvidiaGpu.new(index: index, name: name, uuid: uuid)
      end
    end
  end
end
