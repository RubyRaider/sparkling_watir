# frozen_string_literal: true

require 'appium_lib_core'
require 'watir'
require_relative './sparkling_watir/screenshot'
require_relative './sparkling_watir/gestures'

module SparklingWatir
  #
  # For driving a native application or a native app context
  #
  class App
    attr_accessor :driver

    include Gestures

    def initialize(opts)
      url = opts[:caps]
      @driver = Appium::Core::Driver.for(opts).start_driver(server_url: 'http://localhost:4723/wd/hub')
    end

    def quit
      driver.quit
    end

    alias close quit

    def element(selector)
      Element.new(driver, selector)
    end

    def screenshot
      Screenshot.new self
    end

    def method_missing(method_name, *arguments, &block)
      if driver.respond_to? method_name
        driver.send method_name, *arguments, &block
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      driver.respond_to?(method_name) || super
    end
  end
end
