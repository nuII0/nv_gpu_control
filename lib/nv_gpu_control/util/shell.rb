# frozen_string_literal: true

module NvGpuControl
  module Util
    # Augments {#`} to log commands and handle error cases
    module Shell
      # Raised on a shell error
      class Error < RuntimeError
        # @return [Process::Status] the process status
        attr_reader :status

        # @return [Array<String>] arguments
        attr_reader :args

        # @return [String] Output of the Command
        attr_reader :result

        def initialize(status, args, result)
          @status = status
          @args = args
          @result = (result || "")
          super("Shell command failed with status #{status.exitstatus}. Arguments: #{args} Result: #{result}")
        end
      end

      def system(*args)
        shell_command(args) do
          [ Kernel.system(*args), $? ]
        end
      end

      def `(command)
        shell_command(command) do
          [ Kernel.`(command), $? ] # `] # - Hack to avoid confusing poor Vim
        end
      end

      def command?(name)
        system('which', name, [:out, :err] => File::NULL)
        $?.success?
      end

      private

      def shell_command(args, &block)
        logger.debug "Shell command: #{args.inspect}"

        result, status = block.call(args)

        # rubocop:disable Style/NumericPredicate
        return result if status == 0 || status.success?

        raise Shell::Error.new(status, args, result)
      end
    end
  end
end
