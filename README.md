# SparklingWatir

Watir for testing your Mobile Devices. Powered by Appium.
This project is a revamp of [Tap watir](https://github.com/watir/tap_watir).

All the inspiration from this project is taken from Tap Watir, so all the credit goes
to the original creators and contributors

If you don't know the watir project here is the [link to the project](http://watir.com/)

This project is still in an alpha stage and under active development.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sparkling_watir'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sparkling_watir

If you want to run the tests on iOS just create a simulator that is an iPhone 8 with os 15.5 or you can change 
the capabilities in spec/config/caps, and you can download the testing app [here](https://github.com/cloudgrey-io/the-app/releases/tag/v1.10.0)

All the credit for the testing app goes to Jonathan Lipps.

If you want to switch between android and iOS capabilties just run:

    $ rake platform[android] or rake platform[ios]

## Initialize driver

You can initialize the driver with the following code:

```ruby
app = SparklingWatir::App.new(caps: opts)
```
The capabilities should include the server url

## Gestures

You can use the following gestures:

**Tap:** Tap on an element

```ruby
app.tap on: button
```

**Double tap:** Double tap on an element

```ruby
app.double_tap on: button
```

**Long press:** Press for a minimum of 0.5 seconds on an element

```ruby
app.long_press on: button
```

**Swipe:** Swipes to an element, there are 4 direction available: :up, :down, :left, :right

```ruby
app.swipe to: button, direction: :up
```

**Scroll:** Scrolls until it finds an element, you need to pass a scrollable view to scroll into, there are 4 direction available: :up, :down, :left, :right
```ruby
app.scroll into: scrollable_view, for: element, direction: :down
```


**More gestures coming soon**

## Element

You can use the following methods on an element:

**wd:** Get the driver from the element

```ruby
element.wd
```

**exists?:** Returns true if element exists, else false

```ruby
element.exists?
```

**present?:** Returns true if element is present, else false

```ruby
element.present?
```

**enabled?:** Returns true if element is enabled, else false

```ruby
element.enabled?
```

**coordinates:** Returns a hash with x and y coordinates

```ruby
element.coordinates
```

**size:** Returns a hash with width and height values

```ruby
element.size
```

**bounds:** Returns a hash with x and y values representing bounds

```ruby
element.bounds
```

**center:** Returns a hash with x and y values representing center

```ruby
element.center
```

**attribute(attribute_name):** Returns the attribute value

```ruby
element.attribute('className')
```

**text:** Returns the text of the element

```ruby
element.text
```

## Waits

You can use the following waits:

**wait_until:** Waits until a condition is true

```ruby
element.wait_until(&:present?)
```

**wait_while:** Waits while a condition is true

```ruby
element.wait_while(&:present?)
```

## Screenshot

You can use the following screenshot methods:

**save:** Saves a screenshot at the given path

```ruby
app.screenshot.save("screenshot.png")
```

**png:** This method represents the screenshot as a PNG image string.

```ruby
app.screenshot.png
```

**base64:** Returns a string representing the screenshot as a Base64 encoded string

```ruby
app-screenshot.base64
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
