class Discount
  attr_reader :limit
  def initialize( options = {} )
    @limit = options[:limit] || 0 
  end

  def apply!(items);end
  class << self
    def descendants
      ObjectSpace.each_object(::Class).select{|klass| klass < self}
    end
  end
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
    ->(item){item.price = @price if item.code == @code}
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
