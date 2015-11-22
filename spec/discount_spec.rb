require 'spec_helper'

describe Discount do

  it "raises an error when limit is not set or is invalid" do
    expect{subject}.to raise_error ArgumentError, "Limit is invalid!"
  end
end

describe ItemDiscount do
  include_context 'data'
  let(:discount){ItemDiscount.with_options(price: 8.5, code: '001', limit: 2)}

  context '#dropped_price' do
    it "returns the dropped price of the item discount is appied" do
      expect(discount.dropped_price).to eq 8.5
    end
  end

  context '#limit' do
    it "limit holds the minimum number of numbers discount starts to count" do
      expect(discount.limit).to eq 2 
    end
  end

  context '#apply' do
    it 'when discount is not active the price of items remain intact' do
      cart = Cart.new( basket1 )
      discount.apply!(cart)
      expect( cart.sum ).to eq 74.2 
    end
    
    it 'when discount is active the price of items changes to dropped price' do
      cart = Cart.new( basket2 )
      discount.apply!(cart)
      expect( cart.sum ).to eq 36.95 
    end

  end
end

describe PurchaseDiscount do
  include_context 'data'

  let(:discount){PurchaseDiscount.with_options( percentage: 10, limit: 60)}

  it "raises an error when percentage is invalid" do
    
  end

  it "leave sum of cart intact when it's smaller than discount's lower limit" do
    cart = Cart.new( basket2 )
    expect( discount.apply!( cart ) ).to eq 38.45
  end

  it "returns correctly then new sum when discount has been applied because of lower limit" do
    cart = Cart.new( basket3 )
    expect( discount.apply!( cart ) ).to eq 75.105 
  end
end
