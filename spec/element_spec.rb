require 'spec_helper'
require_relative '../lib/sparkling_watir/element'
require_relative '../lib/sparkling_watir/wait'

describe 'Element' do
  let(:app) { @app }

  def header
    if app.capabilities[:platform_name] == 'Android'
      app.element(xpath: '//android.view.ViewGroup[@content-desc="container header"]/android.widget.TextView')
    else
      app.element(xpath: '//XCUIElementTypeStaticText[@name="Products"]')
    end
  end

  describe '#attribute' do
    it 'returns a specific element attribute' do
      attribute = if app.capabilities[:platform_name] == 'Android'
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
