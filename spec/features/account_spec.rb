require 'account'

describe Account do

  subject(:account) { described_class.new }

  it 'should have 0 balance when initialised' do
    expect(account.balance).to eq 0
  end
  it 'should have empty history array when initialised' do
    expect(account.history).to eq []
  end
end
