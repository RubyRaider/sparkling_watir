# frozen_string_literal: true

require_relative 'spec_helper'
require_relative '../lib/sparkling_watir/gestures'
require_relative 'pages/home_page'
require_relative 'pages/pdp_page'

describe 'Gestures' do
  let(:app) { @app }
  let(:home_page) { HomePage.new(app) }
  let(:pdp_page) { PdpPage.new(app) }
  let(:backpack) { home_page.backpack }
  let(:counter) { pdp_page.counter }
  let(:bike) { home_page.bike }
  let(:header) { home_page.header }
  let(:onesie) { home_page.onesie }
  let(:price) { pdp_page.price }
  let(:plus_button) { pdp_page.plus_button }
  let(:shirt) { home_page.shirt }
  let(:scroll_view) { home_page.scroll_view }

  it '#tap' do
    app.tap on: backpack
    expect(price).to be_present
  end

  it '#double_tap' do
    app.tap on: backpack
    app.double_tap on: plus_button
    expect(counter).to be_present
  end

  it '#long_press' do
    app.long_press on: backpack
    expect(price).to be_present
  end

  it '#swipe_down' do
    app.swipe to: shirt, direction: :down
    expect(header).to_not be_present
  end

  it '#swipe_up' do
    app.swipe to: shirt, direction: :down
    app.swipe to: backpack, direction: :up
    expect(header).to be_present
  end

  it '#swipe_right' do
    app.swipe to: bike, direction: :right
  end

  it '#swipe_left' do
    app.swipe to: backpack, direction: :left
  end

  it '#scroll_down' do
    app.scroll into: scroll_view, for: onesie, direction: :down
    expect(header).to_not be_present
  end

  it '#scroll_up' do
    app.scroll into: scroll_view, for: onesie, direction: :down
    app.scroll into: scroll_view, for: onesie, direction: :up
    expect(header).to be_present
  end
end
