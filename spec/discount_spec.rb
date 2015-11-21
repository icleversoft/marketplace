require 'spec_helper'

describe Discount do
  it_behaves_like 'discount'
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

  #it "raises an error when dropped_price is not set" do
    #expect{ItemDiscount.with_options(items: diff_items, limit: 0)}.to raise_error ArgumentError, "Dropped price should have a positive value!"
  #end

  #it "raises an error when dropped_price is not set" do
    #expect{ItemDiscount.with_options(items: same_items, limit: 0)}.to raise_error ArgumentError, "Dropped price should have a positive value!"
  #end

  #it "raises an error when dropped_price is not a positive number" do
    #expect{ItemDiscount.with_options(items: same_items, limit: 0, dropped_price: 0)}.to raise_error ArgumentError, "Dropped price should have a positive value!"
  #end

  #it "raises an error when limit is not greater than 0" do
    #expect{ItemDiscount.with_options(items: same_items, limit: 0, dropped_price: 1)}.to raise_error ArgumentError, "Limit should be greater than 0"
  #end
end

describe PurchaseDiscount do
  it_behaves_like 'discount'
end
