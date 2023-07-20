require_relative 'base_page'

class PdpPage < BasePage
  def plus_button
    if app.android?
      app.element(xpath: '//android.view.ViewGroup[@content-desc="counter plus button"]/android.widget.ImageView')
         .wait_until(&:present?)
    else
      app.element(accessibility_id: 'counter plus button').wait_until(&:present?)
    end
  end

  def counter
    if app.android?
      app.element(xpath: '//android.view.ViewGroup[@content-desc="counter amount"]/android.widget.TextView')
         .wait_until(&:present?)
    else
      app.element(predicate: 'label == "3"').wait_until(&:present?)
    end
  end

  def price
    app.element(accessibility_id: 'product price').wait_until(&:present?)
  end
end
