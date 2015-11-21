class Checkout
  def initialize( rules )
    @items = []
    @rules = rules
    @total_price = 0.0
  end

  def scan( item )
    @items << item
  end

  def price
    @total_price > 0.0 ? @total_price : apply_rules
  end

  private
  def apply_rules
    apply_item_discount( @rules.select{|i| i.is_a?(ItemDiscount) } )
  end

  def apply_item_discount( item_discounts )
    item_discounts.each do |idisc|
      idisc.apply!(@items)
    end
  end
end
