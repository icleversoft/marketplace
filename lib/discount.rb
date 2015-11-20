class Discount
  attr_reader :items, :limit
  def initialize( options = {} )
    @items = options[:items] || []
    @limit = options[:limit] 
    raise ArgumentError.new("Discount requires at least one item!") if @items.empty?
    raise ArgumentError.new("Discount requires a limit!") unless @limit
  end

  def active?
    true
  end
end

class ItemDiscount < Discount
  class << self
    def with_options( options = {} )
      super( options )
      @price = options[:dropped_price] || 0.0
      raise ArgumentError.new("Dropped price should have a positive value!") if price <= 0.0
      raise ArgumentError.new("Limit should be greater than 0") if limit < 1
    end
  end

  def price
    @price.to_f
  end

  def limit
    @limit.to_i
  end

  def active?
    items.count >= limit
  end

  def apply!
    items.collect!{|i| i.price = @price} if active?
  end
end


class PurchaseDiscount < Discount
  class << self
    def with_options( options = {} )
      super( items )
      @percentage = options[:percentage] || 0.0
      raise ArgumentError.new("Percentage should be greater than 0!")
    end
  end

  def active?
    total_cost > limit
  end

  def total 
    active? ? total_cost.to_f * @percentage / 100.0 : total_cost
  end

  private
  def total_cost
    items.map(&:price).inject(&:+)
  end
end
