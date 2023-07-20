# frozen_string_literal: true

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
      coordinates = { x: opts[:x] || opts[:on].center[:x], y: opts[:y] || opts[:on].center[:y] }
      tap = action(:touch, 'tap')
      tap.create_pointer_move(duration: 0.1, x: coordinates[:x], y: coordinates[:y], origin: VIEWPORT)
      tap.create_pointer_down(:left)
      tap.create_pause(opts[:duration] || 0)
      tap.create_pointer_up(:left)
      perform tap
    end

    alias press tap

    def double_tap(opts = {})
      double_tap = action(:touch, 'double_tap')
      coordinates = { x: opts[:x] || opts[:on].center[:x], y: opts[:y] || opts[:on].center[:y] }
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

    def long_press(opts = {})
      tap(duration: opts[:duration] || 0.5, on: opts[:on])
    end

    def swipe(opts = {})
      coordinates = select_direction(opts[:to], opts[:direction], opts[:scrollable])
      execute_swipe(coordinates)
    end

    def scroll(opts = {})
      timeout = Time.now + 30
      while Time.now < timeout
        swipe to: opts[:into], direction: opts[:direction], scrollable: true
        break if opts[:for].present?
      end
    end

    private

    def execute_swipe(coordinates)
      finger = action(:touch, 'swipe')
      finger.create_pointer_move(duration: 0, x: coordinates[:start_coordinates][:x],
                                 y: coordinates[:start_coordinates][:y],
                                 origin: VIEWPORT)
      finger.create_pointer_down(:left)
      finger.create_pause(0.6)
      finger.create_pointer_move(duration: 0.6, x: coordinates[:end_coordinates][:x],
                                 y: coordinates[:end_coordinates][:y],
                                 origin: VIEWPORT)
      finger.create_pointer_up(:left)
      finger.create_pointer_down(:left)

      perform finger
    end

    def select_direction(element, direction, scrollable)
      start_coordinates, end_coordinates = case direction
                                           when :down
                                             select_down(element)
                                           when :up
                                             select_up(element, scrollable)
                                           when :left, :right
                                             select_horizontal(element)
                                           else
                                             raise "You selected an invalid direction. The valid directions are: :down, :up, :left, :right"
                                           end

      {
        start_coordinates: { x: start_coordinates[:x], y: start_coordinates[:y] },
        end_coordinates: { x: end_coordinates[:x], y: end_coordinates[:y] }
      }
    end

    def select_down(element)
      start_x = element.center[:x]
      start_y = @driver.window_size.height * 0.8
      end_x = element.center[:x]
      end_y = element.center[:y]

      [{x: start_x, y: start_y}, {x: end_x, y: end_y}]
    end

    def select_up(element, scrollable)
      start_x = @driver.window_size.width / 2
      start_y = @driver.window_size.height * 0.2
      end_x = element.center[:x]
      end_y = scrollable ? element.center[:y] : element.center[:y] / 0.5

      [{x: start_x, y: start_y}, {x: end_x, y: end_y}]
    end

    def select_horizontal(element)
      start_x = @driver.window_size.width
      start_y = element.center[:y]
      end_x = element.center[:x]
      end_y = element.center[:y]

      [{x: start_x, y: start_y}, {x: end_x, y: end_y}]
    end
  end
end
