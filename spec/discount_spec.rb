require 'spec_helper'

describe Discount do
  it_behaves_like 'discount'

  it 'returns the descendants' do
    expect(Discount.descendants).to match_array [PurchaseDiscount, ItemDiscount]
  end
end

describe ItemDiscount do
  include_context 'data'
  it_behaves_like 'discount'
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
  it_behaves_like 'discount'
end
