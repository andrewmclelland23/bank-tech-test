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

  describe '#withdraw' do
    it 'should subtract value from balance' do
      account.deposit(100)
      account.withdraw(50)
      expect(account.balance).to eq 50
    end
    it 'should raise an error if withdaw will bring account to negative balance' do
      expect { account.withdraw(50) }.to raise_error("Error: Insufficient Funds")
    end
  end
end
