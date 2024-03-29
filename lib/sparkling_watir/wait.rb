# frozen_string_literal: true

require_relative 'wait/timer'

module SparklingWatir
  # This module is in charge of handling all the waits
  module Wait
    class TimeoutError < StandardError; end

    INTERVAL = 0.1

    class << self
      #
      # @!attribute timer
      #   Access TapWatir timer implementation in use.
      #   @see Timer
      #   @return [#wait]
      #

      attr_writer :timer

      def timer
        @timer ||= Timer.new
      end

      #
      # Waits until the block evaluates to true or times out.
      #
      # @example
      # TODO: Add examples
      #
      # @param [Integer] timeout How long to wait in seconds
      # @param [String] message Message to raise if timeout is exceeded
      # @param [Object, NilClass] object Object to evaluate block against
      # @raise [TimeoutError] if timeout is exceeded
      #

      def until(timeout: nil, message: nil, interval: nil, object: nil)
        timeout ||= Watir.default_timeout
        run_with_timer(timeout, interval) do
          result = yield(object)
          return result if result
        end
        raise TimeoutError, message_for(timeout, object, message)
      end

      #
      # Wait while the block evaluates to true or times out.
      #
      # @example
      # TODO: Add examples
      #
      # @param [Integer] timeout How long to wait in seconds
      # @param [String] message Message to raise if timeout is exceeded
      # @param [Object, NilClass] object Object to evaluate block against
      # @raise [TimeoutError] if timeout is exceeded
      #

      def while(timeout: nil, message: nil, interval: nil, object: nil)
        timeout ||= Watir.default_timeout
        run_with_timer(timeout, interval) { return unless yield(object) }
        raise TimeoutError, message_for(timeout, object, message)
      end

      private

      def message_for(timeout, object, message)
        message = message.call(object) if message.is_a?(Proc)
        err = "timed out after #{timeout} seconds"
        err << ", #{message}" if message

        err
      end

      def run_with_timer(timeout, interval)
        if timeout.zero?
          yield
        else
          timer.wait(timeout) do
            yield
            sleep interval || INTERVAL
          end
        end
      end
    end
  end

  # THis module provides wait utility methods
  module Waitable
    #
    # Waits until the condition is true.
    #
    # @example
    # TODO: Add examples
    #

    def wait_until(timeout: nil, message: nil, interval: nil, **opt, &blk)
      message ||= proc { |obj| "waiting for true condition on #{obj.inspect}" }

      # TODO: Consider throwing argument error for mixing block & options
      proc = create_proc(opt, &blk)

      Wait.until(timeout: timeout, message: message, interval: interval, object: self, &proc)

      self
    end

    #
    # @example
    # Add examples
    #
    def wait_while(timeout: nil, message: nil, interval: nil, **opt, &blk)
      message ||= proc { |obj| "waiting for false condition on #{obj.inspect}" }

      # TODO: Add examples
      proc = create_proc(opt, &blk)

      Wait.while(timeout: timeout, message: message, interval: interval, object: self, &proc)

      self
    end

    private

    def create_proc(opt)
      proc do
        reset! if opt.delete(:element_reset) && is_a?(Element)
        (opt.empty? || match_attributes(opt).call) && (!block_given? || yield(self))
      end
    end

    def match_attributes(opt)
      proc do
        opt.keys.all? do |key|
          expected = opt[key]
          actual = is_a?(Element) && !respond_to?(key) ? attribute_value(key) : send(key)
          compare_attributes(actual, expected)
        end
      end
    end

    def compare_attributes(actual, expected)
      case expected
      when Regexp then expected =~ actual
      when Numeric then expected == actual
      else expected.to_s == actual
      end
    end
  end
end
