require_relative 'base_page'

class HomePage < BasePage
  def backpack
    if app.android?
      app.element(xpath: xpath_for(:backpack)).wait_until(&:present?)
    else
      app.element(accessibility_id: 'Sauce Labs Backpack').wait_until(&:present?)
    end
  end

  def bike
    if app.android?
      app.element(xpath: xpath_for(:bike)).wait_until(&:present?)
    else
      app.element(accessibility_id: 'Sauce Labs Bike Light').wait_until(&:present?)
    end
  end

  def shirt
    if app.android?
      app.element(xpath: xpath_for(:shirt)).wait_until(&:present?)
    else
      app.element(accessibility_id: 'Sauce Labs Bolt T-Shirt').wait_until(&:present?)
    end
  end

  def header
    if app.android?
      app.element(xpath: '//android.view.ViewGroup[@content-desc="container header"]/android.widget.TextView')
    else
      app.element(xpath: '//XCUIElementTypeStaticText[@name="Products"]')
    end
  end

  def scroll_view
    if app.android?
      app.element(xpath: '//android.view.ViewGroup[@content-desc="products screen"]/android.widget.ScrollView')
         .wait_until(&:present?)
    else
      app.element(
        xpath: '(//XCUIElementTypeOther[@name="Products Sauce Labs Backpack $29.99 󰓏 󰓏 󰓏 󰓏 󰓏 Sauce Labs Bike Light $9.99 󰓏 󰓏 󰓏 󰓏 󰓏 Sauce Labs Bolt T-Shirt $15.99 󰓏 󰓏 󰓏 󰓏 󰓏 Sauce Labs Fleece Jacket $49.99 󰓏 󰓏 󰓏 󰓏 󰓏 Sauce Labs Onesie $7.99 󰓏 󰓏 󰓏 󰓏 󰓏 Test.allTheThings() T-Shirt $15.99 󰓏 󰓏 󰓏 󰓏 󰓏 © 2023 Sauce Labs. All Rights Reserved. Terms of Service | Privacy Policy. Vertical scroll bar, 2 pages Horizontal scroll bar, 1 page"])[14]/XCUIElementTypeScrollView'
      )
         .wait_until(&:present?)
    end
  end

  def onesie
    if app.android?
      app.element(
        xpath: '(//android.view.ViewGroup[@content-desc="store item"])[3]/android.view.ViewGroup[1]/android.widget.ImageView'
      ).wait_until(&:present?)
    else
      app.element(accessibility_id: 'Sauce Labs Onesie').wait_until(&:present?)
    end
  end

  def review_star
    if app.android?
      app.elements(xpath: '(//android.view.ViewGroup[@content-desc="review star 1"])[1]/android.widget.TextView')
    else
      app.elements(xpath: '(//XCUIElementTypeOther[@name="review star 1"])[2]')
    end
  end

  def xpath_for(element)
    case element
    when :backpack then item_number = 1; view_group = 1
    when :bike then item_number = 3; view_group = 1
    when :shirt then item_number = 2; view_group = 1
    else raise 'Invalid element'
    end
    "(//android.view.ViewGroup[@content-desc=\"store item\"])[#{item_number}]/android.view.ViewGroup[#{view_group}]/android.widget.ImageView"
  end
end
