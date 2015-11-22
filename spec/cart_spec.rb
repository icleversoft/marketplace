require 'spec_helper'

describe Cart do
  include_context 'data'
  let(:cart){Cart.new(basket1)}

  it "is actually an array" do
    expect(cart).to be_an Array
  end

  it "responds to prices" do
    expect(cart).to respond_to :prices
  end

  it "responds to sum" do
    expect(cart).to respond_to :sum
  end

  it "responds to count_of" do
    expect(cart).to respond_to :sum
  end

  context '#prices' do
    it "holds all item prices" do
      expect(cart.prices).to match_array [9.25, 45.0, 19.95]
    end
  end

  context '#sum' do
    it "returns the sum of item prices" do
      expect(cart.sum).to eq 74.20
    end
  end

  context '#count_of' do
    it "returns correctly the number of items in cart according to their code" do
      expect(cart.count_of('001')).to eq 1
      expect(Cart.new(basket3).count_of('001')).to eq 2
    end
  end

  context '#add_item' do
    it "can add an item to cart" do
      cart.add_item( item1 )
      expect(cart.count_of('001')).to eq 2
    end
  end
end
