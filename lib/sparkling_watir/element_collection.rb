require_relative 'element'

module SparklingWatir
  class ElementCollection
    include Enumerable

    attr_reader :driver, :selector

    def initialize(driver, selector)
      @driver = driver
      @selector = selector
      @collection = create_collection
    end

    def add(element)
      @collection << element
    end

    def each
      @collection.each do |element|
        yield element
      end
    end

    alias length count
    alias size count

    alias empty? none?

    alias exist? any?
    alias exists? any?

    def to_a
      @collection
    end

    def [](value)
      @collection[value]
    end

    def first
      @collection.first
    end

    def last
      @collection.last
    end

    private

    def create_collection
      elements = driver.find_elements selector

      elements.map { |element| Element.new(driver, nil, element) }
    end
  end
end
