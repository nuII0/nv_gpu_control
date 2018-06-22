require_relative 'exception'

module NvGpuControl
  module Action

    # Enables control of maximum Power Draw for a GPU.
    class PowerLimit
      include Loggable

      # @param gpu_index [Integer] assigned index for GPU by nvidia system tools.
      def initialize(gpu_index:)
        @index = gpu_index
      end

      # @return [String] current power draw with unit e.g. "160 W"
      def current
        NvidiaSmi.run('--query-gpu=power.limit', '--format=csv,noheader', '-i', @index)
      end

      # @return [Integer] current power draw e.g. "160"
      def current_watt
        current.to_i
      end

      # Sets a new Limit for maximum Power Draw.
      # @param watt [Integer] the new limit
      def set(watt:)
        if watt.eql? current_watt
          logger.info "Current powerlimit is already at #{current}"
          return
        end

        result = NvidiaSmi.run('-i', @index, '-pl', watt)
        logger.info(result)

        unless current_watt.eql? watt
          raise VerificationError, "Powerlimit could not be set to #{watt} W. Current: #{current}"
        end
      end
    end
  end
end
