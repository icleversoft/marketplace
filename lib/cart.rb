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
end
