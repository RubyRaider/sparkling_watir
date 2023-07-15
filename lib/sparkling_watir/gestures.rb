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

    def tap(opts = {})
      coordinates = { x: opts[:x] || center[:x], y: opts[:y] || center[:y] }
      tap = action(:touch, 'tap')
      tap.create_pointer_move(duration: 0.1, x: coordinates[:x], y: coordinates[:y], origin: VIEWPORT)
      tap.create_pointer_down(:left)
      tap.create_pointer_up(:left)
      perform tap
    end

    alias press tap

    def double_tap(opts = {})
      double_tap = action(:touch, 'double_tap')
      coordinates = { x: opts[:x] || center[:x], y: opts[:y] || center[:y] }
      double_tap.create_pointer_move(duration: 0, x: coordinates[:x], y: coordinates[:y], origin: VIEWPORT)
      double_tap.create_pointer_down(:left)
      double_tap.create_pause(0.1)
      double_tap.create_pointer_up(:left)
      double_tap.create_pause(0.1)
      double_tap.create_pointer_down(:left)
      double_tap.create_pause(0.1)
      double_tap.create_pointer_up(:left)

      perform double_tap
    end

    def swipe(opts = {})
      start_coordinates = select_direction(opts[:start_x] || opts[:to].center[:x], opts[:start_y] || opts[:to].center[:y], opts[:direction])
      end_coordinates = select_direction(opts[:end_x] || opts[:to].center[:x], opts[:end_y] || opts[:to].center[:y], opts[:direction])
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

    def select_direction(x, y, direction = nil)
      case direction
      when :down then { x: x, y: y } # For swipe down, decrease y-coordinate
      when :up then { x: x, y: y  } # For swipe up, increase y-coordinate
      when :left, :right then { x: x, y: y }
      else raise "You selected an invalid direction. The valid directions are: :down, :up, :left, :right"
      end
    end
  end
end
