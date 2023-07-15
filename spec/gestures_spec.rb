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
      app.tap on: backpack
      expect(title).to be_present
    end

    it '#double_tap' do
      app.tap on: backpack
      plus_button = app.element(accessibility_id: 'counter plus button').wait_until(&:present?)
      app.double_tap on: plus_button
      counter = app.element(predicate: 'label == "3"').wait_until(&:present?)
      expect(counter).to be_present
    end

    it '#swipe_down' do
      app.swipe to: shirt, direction: :down
      header = app.element(xpath: '//XCUIElementTypeStaticText[@name="Products"]')
      expect(header).to_not be_present
    end

    it '#swipe_up' do
      app.swipe to: shirt, direction: :down
      app.swipe to: backpack, direction: :up
      header = app.element(xpath: '//XCUIElementTypeStaticText[@name="Products"]')
      expect(header).to be_present
    end

    it '#swipe_right' do
      app.swipe to: bike, direction: :right
    end

    it '#swipe_left' do
      app.swipe to: backpack, direction: :left
    end
  end
end
