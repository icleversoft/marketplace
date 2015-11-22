module Calculator 
  def prices
    map(&:price) || 0.0
  end

  def sum
    prices.inject(&:+)
  end
end

class Cart < Array
  include Calculator

  def count_of( code )
    self.select{|i| i.code == code}.length
  end

  def add_item( item )
    self << item
  end
end
