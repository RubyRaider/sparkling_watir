# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/sparkling_watir/gestures'

describe 'Gestures' do
  let(:app) { @app }
  let(:backpack) { app.element(accessibility_id: 'Sauce Labs Backpack').wait_until(&:present?) }
  let(:bike) { app.element(accessibility_id: 'Sauce Labs Bike Light').wait_until(&:present?) }
  let(:shirt) { app.element(accessibility_id: 'Sauce Labs Bolt T-Shirt').wait_until(&:present?) }
  let(:title) { app.element(accessibility_id: 'Sauce Labs Backpack').wait_until(&:present?) }

  it '#tap' do
    backpack.tap
    expect(title).to be_present
  end

  it '#double_tap' do
    backpack.double_tap
    title = app.element(accessibility_id: 'API calls')
    expect(title.wait_until(&:present?)).to be_present
  end

  it '#swipe_down' do
    backpack.swipe to: shirt, direction: :down
    expect(backpack).to_not be_present
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
