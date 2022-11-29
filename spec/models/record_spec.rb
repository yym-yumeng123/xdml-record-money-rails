require 'rails_helper'

RSpec.describe Record, type: :model do
  it "amount is required" do
    record = Record.create category: 'outgoings', notes: '请客'
    expect(record.errors.details[:amount][0][:error]).to eq(:blank)
  end

  it "category is required" do
    record = Record.create amount: 10000, notes: '请客'
    expect(record.errors.details[:category][0][:error]).to eq(:blank)
  end

  it 'category must be outgoings or income' do
    expect { Record.create amount: 10000, category: 'outgoing' }.to raise_error(ArgumentError)
  end
end