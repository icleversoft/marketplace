class Checkout
  def initialize( rules )
    @cart = Cart.new 
    @rules = rules
    @total_price = 0.0
  end

  def scan( item )
    @cart.add_item( item )
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
    @total_price = discount ? discount.apply!(@cart) : calc_total 
  end

  def item_discount 
    ->(idisc){idisc.apply!(@cart)}
  end

  def calc_total
    @cart.sum
  end


end
