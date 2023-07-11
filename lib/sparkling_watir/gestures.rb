# frozen_string_literal: true

require 'appium_lib_core/common/touch_action/touch_actions'
require 'selenium/webdriver/common/interactions/interactions'

module SparklingWatir
  # This module handles all the possible gestures
  module Gestures
    VIEWPORT = ::Selenium::WebDriver::Interactions::PointerMove::VIEWPORT

    def action(kind, name)
      @driver.action.add_pointer_input(kind, name)
    end

    def perform(*actions)
      @driver.perform_actions actions
    end

    def tap(timeout = nil)
      wait_until(timeout: timeout, &:present?)
      tap = action(:touch, 'tap')
      tap.create_pointer_move(duration: 0.1, x: center[:x], y: center[:y], origin: VIEWPORT)
      tap.create_pointer_down(:left)
      tap.create_pointer_up(:left)
      perform tap
    end

    alias press tap

    def double_tap
      wait_until(&:present?)
      double_tap = action(:touch, 'double_tap')
      tap.create_pointer_move(duration: 0.1, x: center[:x], y: center[:y], origin: VIEWPORT)
      double_tap.create_pointer_down(:left)
      double_tap.create_pointer_up(:left)
      double_tap.create_pointer_down(:left)
      double_tap.create_pointer_up(:left)

      perform double_tap
    end

    def swipe(opts = {})
      wait_until(&:present?)
      start_coordinates = self.center
      end_coordinates = select_direction(opts[:to].wait_until(&:exists?).center[:x], opts[:to].wait_until(&:exists?).center[:y], opts[:direction])
      duration = opts[:duration] || 1
      execute_swipe(duration, start_coordinates, end_coordinates)
    end

    private

    def execute_swipe(duration, start_coordinates, end_coordinates)
      finger = action(:touch, 'swipe')
      finger.create_pointer_move(duration: duration, x: start_coordinates[:x], y: start_coordinates[:y],
                                 origin: VIEWPORT)
      finger.create_pointer_down(:left)
      finger.create_pointer_move(duration: duration, x: end_coordinates[:x], y: end_coordinates[:y],
                                 origin: VIEWPORT)
      finger.create_pointer_up(:left)
      perform finger
    end

    def select_direction(x, y, direction)
      case direction
      when :down then { x: x, y: - y } # For swipe down, decrease y-coordinate
      when :up then { x: x, y: y * 20  } # For swipe up, increase y-coordinate
      when :left, :right then { x: x, y: y }
      else raise "You selected an invalid direction. The valid directions are: :down, :up, :left, :right"
      end
    end
  end
end
