class Discount
  attr_reader :limit
  def initialize( options = {} )
    @limit = options[:limit] || 0 
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
    items.collect!(&apply_dicount) if active?(items)
  end
  
  private
  def active?(items)
    items_for_discount(items).count >= limit
  end

  def items_for_discount( items )
    items.select{|i| i.code == @code}.map(&:code)
  end

  def apply_discount
    ->(item){items_for_discount.include?(item.code) ? item.price = dropped_price : item.price}
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
