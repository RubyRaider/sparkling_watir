# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/sparkling_watir/element'
require_relative '../lib/sparkling_watir/wait'

describe 'Wait' do
  let(:app) { @app }

  def header
    if app.capabilities[:platform_name] == 'Android'
      app.element(xpath: '//android.view.ViewGroup[@content-desc="container header"]/android.widget.TextView')
    else
      app.element(xpath: '//XCUIElementTypeStaticText[@name="Products"]')
    end
  end

  def backpack
    if app.capabilities[:platform_name] == 'Android'
      app.element(xpath: '(//android.view.ViewGroup[@content-desc="store item"])[1]/android.view.ViewGroup[1]/android.widget.ImageView')
    else
      app.element(accessibility_id: 'Sauce Labs Backpack')
    end
  end

  describe '#wait_until' do
    it 'waits until the element is present' do
      expect(header.wait_until(&:present?).class).to be SparklingWatir::Element
    end
  end

  describe '#wait_while' do
    it 'while the element is not present' do
      expect(backpack.wait_while { |element| !element.present? }).to be_truthy
    end
  end
end
