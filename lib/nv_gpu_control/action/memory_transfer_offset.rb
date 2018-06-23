require_relative 'exception'

module NvGpuControl
  module Action

    # Enables control of the memory transfer clock of a GPU
    class MemoryTransferOffset
      include Loggable

      # @param gpu_index [Integer] assigned index for GPU by nvidia system tools.
      def initialize(gpu_index:)
        @index = gpu_index
      end

      # @param power_level [Integer] specified power level (must be 0-4)
      # @return [String] current memory transfer offset in Mhz e.g. "100 Mhz"
      def current(power_level:)
        check_powerlevel(power_level)
        current_mhz(power_level: power_level).to_s + " Mhz"
      end

      # @return [Integer] current power draw e.g. "160"
      def current_mhz(power_level:)
        check_powerlevel(power_level)
        NvidiaSettings.run("--query", "[gpu:#{@index}]/GPUMemoryTransferRateOffset[#{power_level}]").match(/.*: (.*)./)[1].to_i
      end

      # Sets a offset for memory transfer clock.
      # @param mhz [Integer] offset to the standard memory transfer clock in Mhz.
      # @param power_level [Integer] specified power level (must be 0-4)
      def set(mhz:, power_level:)
        target_value = mhz
        current_value = current_mhz(power_level: power_level)

        if target_value.eql? current_value
          logger.info "Current ClockOffset at PowerLevel #{power_level} is already at #{target_value} Mhz"
          return
        end

        result = NvidiaSettings.run("-a", "[gpu:#{@index}]/GPUMemoryTransferRateOffset[#{power_level}]=#{target_value}")
        logger.info(result)

        new_value = current_mhz(power_level: power_level)

        unless target_value.eql? new_value
          raise VerificationError, "Memory Transfer Offset could not be set to #{target_value} Mhz for PowerLevel #{power_level}. Current: #{new_value}"
        end
      end

      private

      def check_powerlevel(level)
        raise ArgumentError, "power_level must be 0-4" unless level.between?(0,4)
      end
    end
  end
end
