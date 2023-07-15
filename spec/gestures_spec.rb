# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/sparkling_watir/gestures'

describe 'Gestures' do
  let(:app) { @app }
  let(:backpack) { app.element(accessibility_id: 'Sauce Labs Backpack').wait_until(&:present?) }
  let(:bike) { app.element(accessibility_id: 'Sauce Labs Bike Light').wait_until(&:present?) }
  let(:shirt) { app.element(accessibility_id: 'Sauce Labs Bolt T-Shirt').wait_until(&:present?) }
  let(:title) { app.element(accessibility_id: 'Sauce Labs Backpack').wait_until(&:present?) }

  context 'from app' do
    it '#tap' do
      app.tap(x: backpack.center[:x], y: backpack.center[:y])
      expect(title).to be_present
    end

    it '#double_tap' do
      backpack.tap
      plus_button = app.element(accessibility_id: 'counter plus button').wait_until(&:present?)
      app.double_tap(x: plus_button.center[:x], y: plus_button.center[:y])
      counter = app.element(predicate: 'label == "3"').wait_until(&:present?)
      expect(counter).to be_present
    end

    it '#swipe_down' do
      app.swipe(start_x: backpack.center[:x],
                start_y: backpack.center[:y],
                end_x: shirt.center[:x],
                end_y: shirt.center[:y], duration: 2, direction: :down)
    end

    it '#swipe_up' do
      backpack.swipe to: shirt, direction: :down
      shirt.swipe to: backpack, direction: :up
    end

    it '#swipe_right' do
      backpack.swipe to: bike, direction: :right
    end

    it '#swipe_left' do
      bike.swipe to: backpack, direction: :left
    end
  end

  context 'from element' do
    it '#tap' do
      backpack.double_tap
      expect(title).to be_present
    end

    it '#double_tap' do
      backpack.tap
      plus_button = app.element(accessibility_id: 'counter plus button').wait_until(&:present?)
      plus_button.double_tap
      counter = app.element(predicate: 'label == "3"').wait_until(&:present?)
      expect(counter).to be_present
    end

    it '#swipe_down' do
      app.swipe(start_x: 108, start_y: 284, end_x: 108, end_y: 584, duration: 2, direction: :down)
    end

    it '#swipe_up' do
      backpack.swipe to: shirt, direction: :down
    end

    it '#swipe_right' do
      backpack.swipe to: bike, direction: :right
    end

    it '#swipe_left' do
      bike.swipe to: backpack, direction: :left
    end
  end
end
