require_relative 'action/power_limit'

module NvGpuControl

  # Represents an actual Nvidia GPU on the system.
  class NvidiaGpu
    attr_reader :power_limit, :index, :name, :uuid

    # @param index [Integer] assigned index for GPU by nvidia system tools.
    # @param name [String] GPU Model Name
    # @param uuid [String] assigned uuid for GPU by nvidia system tools.
    def initialize(index:, name:, uuid: )
      @index = index
      @name = name
      @uuid = uuid
      @power_limit = NvGpuControl::Action::PowerLimit.new(gpu_index: @index)
      #@memory_clock = NvGpuControl::Action::MemoryClock.new(index: @index)
      #@core_clock = NvGpuControl::Action::CoreClock.new(index: @index)
    end
  end
end
