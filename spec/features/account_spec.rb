require 'account'

describe Account do

  subject(:account) { described_class.new }

  it 'should have 0 balance when initialised' do
    expect(account.balance).to eq 0
  end
  it 'should have empty history array when initialised' do
    expect(account.history).to eq []
  end

  describe '#deposit' do
    it 'should add value to balance' do
      account.deposit(50)
      expect(account.balance).to eq 50
    end
  end
end
