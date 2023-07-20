require 'spec_helper'
require_relative '../lib/sparkling_watir/element'
require_relative '../lib/sparkling_watir/wait'
require_relative 'pages/home_page'

describe 'Element' do
  let(:app) { @app }
  let(:home_page) { HomePage.new(app) }
  let(:header) { home_page.header }

  describe '#attribute' do
    it 'returns a specific element attribute' do
      attribute = if app.android?
                    header.wait_until(&:present?).attribute('className')
                  else
                    header.wait_until(&:present?).attribute('UID')
                  end
      expect(attribute.class).to be String
    end
  end

  describe '#text' do
    it 'returns the text for a specific element' do
      expect(header.wait_until(&:present?).text).to eql 'Products'
    end
  end
end
