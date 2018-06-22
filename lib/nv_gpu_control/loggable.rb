# frozen_string_literal: true

module NvGpuControl
  # Adds a {#logger} method to the class
  module Loggable
    # @return the logger for this class
    def logger
      @logger ||= NvGpuControl.logger[self]
    end
  end
end

