require 'spec_helper'

describe Discount do
  let(:item){Item.new({code: "001", name: "Product a", price: 3.0})}
  let(:discount){Discount.new({items:[item], limit: 0})}
  it "applies to an array of items" do
    expect(discount).to respond_to :items
  end

  it "items is an array" do
    expect(discount.items).to be_an Array
  end

  it "it has a limit" do
    expect(discount).to respond_to :limit
  end

  it "responds to active?" do
    expect(discount).to respond_to :active?
  end

  it "raises an exception when items array is empty" do
    expect{subject}.to raise_error ArgumentError, "Discount requires at least one item!"
  end
end
