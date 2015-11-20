class Item
  attr_accessor :price, :code, :name

  def initialize(options = {})
    @code = options[:code] || ''
    @name = options[:name] || ''
    @price = options[:price] || 0.0
  end
end
