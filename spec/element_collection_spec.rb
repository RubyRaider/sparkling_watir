# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/sparkling_watir/element_collection'
require_relative '../lib/sparkling_watir/wait'
require_relative 'pages/home_page'

describe 'Element Collection' do
  let(:app) { @app }
  let(:home_page) { HomePage.new(app) }
  let(:header) { home_page.header }
  let(:backpack) { home_page.backpack }

  describe '#count' do
    it 'return the total amount of elements in the collection' do
      header.wait_until(&:present?)
      expect(app.elements(xpath: '//XCUIElementTypeStaticText[@name="Products"]').count).to eql 1
    end
  end

  describe '#[]' do
    context 'when elements do not exist' do
      it 'returns an empty array' do
        expect(app.elements(id: 'non-existing')).to be_empty
      end
    end
  end

  describe '#to_a' do
    it 'converts an element collection into an array' do
      header.wait_until(&:present?)
      expect(app.elements(xpath: '//XCUIElementTypeStaticText[@name="Products"]').to_a.first.class)
        .to be SparklingWatir::Element
    end
  end

  describe '#first' do
    it 'returns the first element' do
      header.wait_until(&:present?)
      expect(app.elements(xpath: '//XCUIElementTypeStaticText[@name="Products"]').first.class)
        .to be SparklingWatir::Element
    end
  end

  describe '#last' do
    it 'returns the last element' do
      header.wait_until(&:present?)
      expect(app.elements(xpath: '//XCUIElementTypeStaticText[@name="Products"]').last.class)
        .to be SparklingWatir::Element
    end
  end
end

