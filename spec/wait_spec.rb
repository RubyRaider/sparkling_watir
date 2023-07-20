# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/sparkling_watir/element'
require_relative '../lib/sparkling_watir/wait'
require_relative 'pages/home_page'

describe 'Wait' do
  let(:app) { @app }
  let(:home_page) { HomePage.new(app) }
  let(:header) { home_page.header }
  let(:backpack) { home_page.backpack }

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
