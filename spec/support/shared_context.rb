require 'spec_helper'

shared_context 'data' do
  let(:item1){Item.new(code: '001', name: 'Travel Card Holder', price: 9.25)}
  let(:item2){Item.new(code: '002', name: 'Personalised cufflinks', price: 45.00)}
  let(:item3){Item.new(code: '003', name: 'Kids T-shirt', price: 19.95)}

  let(:basket1){[item1, item2, item3]} 
  let(:basket2){[item1, item3, item1]} 
  let(:basket3){[item1, item2, item1, item3]} 

end
