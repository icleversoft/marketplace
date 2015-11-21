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
end
