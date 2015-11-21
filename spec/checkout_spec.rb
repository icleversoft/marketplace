require 'spec_helper'

describe Checkout do
  include_context 'data'
  let(:rules) do
    [
      ItemDiscount.with_options( price: 8.50, limit: 2, code: '001' )
    ]
  end
  it "doesn't apply any discount when rules don't being activated" do
    co = Checkout.new( rules )
    basket1.each{|i| co.scan(i)}
    expect(co.price).to eq 66.78
  end

end
