class Discount
  attr_reader :limit
  def initialize( options = {} )
    @limit = options[:limit] || 0 
    raise ArgumentError.new("Limit is invalid!") if @limit <= 0
  end

  def apply!(items);end
end

class ItemDiscount < Discount
  class << self
    def with_options( options = {} )
      ItemDiscount.new( options )
    end
  end

  def initialize( options = {} )
    super( options )
    @price = options[:price] || 0.0
    @code = options[:code] || ''
  end

  def dropped_price
    @price.to_f
  end

  def limit
    @limit.to_i
  end

  def apply!(items)
    @items = items
    @items.each(&item_discount) if active?
  end

  private
  def active?
    @items.count_of(@code) >= limit
  end

  def item_discount
    ->(item){item.price = @price if valid_item_for_discount?(item)}
  end

  def valid_item_for_discount?(item)
    item.code == @code && item.price > @price
  end

end


class PurchaseDiscount < Discount
  class << self
    def with_options( options = {} )
      PurchaseDiscount.new( options  )
    end
  end

  def initialize( options = {} )
    super( options )
    @percentage = options[:percentage] || 0.0
    raise ArgumentError.new("Percentage is not valid") unless valid_percentage?
  end


  def limit
    @limit.to_f
  end

  def apply!( items )
    @items = items
    total
  end

  def percentage
    @percentage.to_f
  end

  private
    def valid_percentage?
      (0..100).cover?(@percentage)
    end

  def total
    active? ? total_cost * (1.0 - percentage / 100.0) : total_cost
  end

  def active?
    total_cost > limit
  end

  def total_cost
    @total || @items.sum
  end

end
