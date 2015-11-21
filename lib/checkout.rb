class Checkout
  def initialize( rules )
    @items = Cart.new 
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
    apply_purchase_discount( @rules.select{|i| i.is_a?(PurchaseDiscount)}.first )
  end

  def apply_item_discount( item_discounts )
    item_discounts.each(&item_discount)
  end

  def apply_purchase_discount( discount )
    @total_price = discount ? discount.apply!(@items) : calc_total 
  end

  def item_discount 
    ->(idisc){idisc.apply!(@items)}
  end

  def calc_total
    @items.sum
  end


end
