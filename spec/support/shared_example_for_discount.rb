require 'spec_helper'

shared_examples 'discount' do

  it "it has a limit" do
    expect(subject).to respond_to :limit
  end

  it "it responds to apply!" do
    expect(subject).to respond_to :apply!
  end

end
