require_relative 'action/power_limit'
require_relative 'action/core_clock_offset'
require_relative 'action/memory_transfer_offset'

module NvGpuControl

  # Represents an actual Nvidia GPU on the system.
  class NvidiaGpu
    attr_reader :power_limit, :index, :name, :uuid
    attr_reader :memory_transfer_offset, :core_clock_offset

    # @param index [Integer] assigned index for GPU by nvidia system tools.
    # @param name [String] GPU Model Name
    # @param uuid [String] assigned uuid for GPU by nvidia system tools.
    def initialize(index:, name:, uuid: )
      @index = index
      @name = name
      @uuid = uuid
      @power_limit = NvGpuControl::Action::PowerLimit.new(gpu_index: @index)
      @memory_transfer_offset = NvGpuControl::Action::MemoryTransferOffset.new(gpu_index: @index)
      @core_clock_offset = NvGpuControl::Action::CoreClockOffset.new(gpu_index: @index)
    end
  end
end
