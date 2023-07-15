# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/sparkling_watir/gestures'

describe 'Gestures' do
  let(:app) { @app }
  let(:backpack_price) { app.element(accessibility_id: 'product price').wait_until(&:present?) }

  def xpath_for(element)
    case element
    when :backpack then item_number = 1; view_group = 1
    when :bike then item_number = 3; view_group = 1
    when :shirt then item_number = 2; view_group = 1
    else raise 'Invalid element'
    end
    "(//android.view.ViewGroup[@content-desc=\"store item\"])[#{item_number}]/android.view.ViewGroup[#{view_group}]/android.widget.ImageView"
  end

  def header
    if app.capabilities[:platform_name] == 'Android'
      app.element(xpath: '//android.view.ViewGroup[@content-desc="container header"]/android.widget.TextView')
         .wait_until(&:present?)
    else
      app.element(xpath: '//XCUIElementTypeStaticText[@name="Products"]').wait_until(&:present?)
    end
  end

  def plus_button
    if app.capabilities[:platform_name] == 'Android'
      app.element(xpath: '//android.view.ViewGroup[@content-desc="counter plus button"]/android.widget.ImageView')
         .wait_until(&:present?)
    else
      app.element(predicate: 'label == "3"').wait_until(&:present?)
    end
  end

  def counter
    if app.capabilities[:platform_name] == 'Android'
      app.element(xpath: '//android.view.ViewGroup[@content-desc="counter amount"]/android.widget.TextView')
         .wait_until(&:present?)
    else
      app.element(predicate: 'label == "3"').wait_until(&:present?)
    end
  end

  before(:example) do
    if app.capabilities[:platform_name] == 'Android'
      @backpack = app.element(xpath: xpath_for(:backpack)).wait_until(&:present?)
      @shirt = app.element(xpath: xpath_for(:shirt)).wait_until(&:present?)
      @bike = app.element(xpath: xpath_for(:bike)).wait_until(&:present?)
    else
      @backpack = app.element(accessibility_id: 'Sauce Labs Backpack').wait_until(&:present?)
      @shirt = app.element(accessibility_id: 'Sauce Labs Bolt T-Shirt').wait_until(&:present?)
      @bike = app.element(accessibility_id: 'Sauce Labs Bike Light').wait_until(&:present?)
    end
  end

  context 'from app' do
    it '#tap' do
      app.tap on: @backpack
      expect(backpack_price).to be_present
    end

    it '#double_tap' do
      app.tap on: @backpack
      app.double_tap on: plus_button
      expect(counter).to be_present
    end

    it '#long_press' do
      app.long_press on: @backpack
      expect(backpack_price).to be_present
    end

    it '#swipe_down' do
      app.swipe to: @shirt, direction: :down
      expect(header).to_not be_present
    end

    it '#swipe_up' do
      app.swipe to: @shirt, direction: :down
      app.swipe to: @backpack, direction: :up
      expect(header).to be_present
    end

    it '#swipe_right' do
      app.swipe to: @bike, direction: :right
    end

    it '#swipe_left' do
      app.swipe to: @backpack, direction: :left
    end
  end
end
