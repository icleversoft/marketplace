require 'spec_helper'

describe Checkout do
  include_context 'data'
  let(:rules) do
    [
      ItemDiscount.with_options( price: 8.50, limit: 2, code: '001' ),
      PurchaseDiscount.with_options( percentage: 10, limit: 60.0 )
    ]
  end

  it "doesn't apply any discount when rules don't being activated" do
    co = Checkout.new( rules )
    basket1.each{|i| co.scan(i)}
    expect(co.price).to eq 66.78
  end

  it "calculates correctly item discount" do
    co = Checkout.new( rules )
    basket2.each{|i| co.scan(i)}
    expect(co.price).to eq 36.95
  end

  it "calculates correctly both item discount and purchase discount" do
    co = Checkout.new( rules )
    basket3.each{|i| co.scan(i)}
    expect(co.price.round(2)).to eq 73.76 
  end
end
