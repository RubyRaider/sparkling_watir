# frozen_string_literal: true

require_relative 'wait'

module SparklingWatir
  #
  # This is a element in the native app context
  #
  class Element
    attr_reader :driver, :selector
    attr_accessor :element

    include Waitable

    def initialize(driver = nil, selector = nil, element = nil)
      @driver = driver
      @selector = selector
      @element = element
    end

    def wd
      element || locate
    end

    def exists?
      assert_exists
      true
    rescue Watir::Exception::UnknownObjectException
      false
    end

    alias exist? exists?

    def present?
      assert_exists
      element&.displayed?
    rescue Watir::Exception::UnknownObjectException
      false
    end

    alias visible? present?

    def enabled?
      assert_exists
      element&.enabled?
    rescue Watir::Exception::UnknownObjectException
      false
    end

    def coordinates
      assert_exists
      element&.location
    end

    alias location coordinates

    def size
      assert_exists
      element&.size
    end

    def bounds
      { x: coordinates.x + size.width, y: coordinates.y + size.height }
    end

    def center
      {
        x: coordinates[:x] + size.width / 2,
        y: coordinates[:y] + size.height / 2
      }
    end

    def attribute(attribute_name)
      wd.attribute(attribute_name)
    end

    def text
      if driver.capabilities[:platform_name] == 'Android'
        attribute('text')
      else
        attribute('label')
      end
    end

    private

    def locate
      @element ||= driver&.find_element(selector)
    rescue Selenium::WebDriver::Error::NoSuchElementError
      nil
    end

    def assert_exists
      locate unless element

      raise Watir::Exception::UnknownObjectException unless element
    end
  end
end
