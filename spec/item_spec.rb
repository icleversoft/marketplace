require 'spec_helper'

describe Item do
  it "has a code" do
    expect(subject).to respond_to :code
  end

  it "has a name" do
    expect(subject).to respond_to :name
  end

  it "has a price" do
    expect(subject).to respond_to :price
  end
end
