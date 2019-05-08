require 'account'
require 'timecop'

describe Account do

  let(:event) { double :event, :new => 'something' }
  subject(:account) { described_class.new }

  it 'should have 0 balance when initialised' do
    expect(account.balance).to eq 0
  end
  it 'should have empty history array when initialised' do
    expect(account.history).to eq []
  end

  describe '#deposit' do
    it 'should add value to balance' do
      account.deposit(50, event)
      expect(account.balance).to eq 50
    end
    it 'should create a new Event with value, new balance and timestamp' do
      time = Time.now
      Timecop.freeze(time)
      account.deposit(50, event)
      expect(event).to have_received(:new).with(value: 50, balance: 50, timestamp: time)
    end
    it 'should record deposit event in history array' do
      expect { account.deposit(50, event) }.to change{ account.history.count }.from(0).to(1)
    end
    it 'should raise an error if value is not a number' do
      expect { account.deposit('hi') }.to raise_error("Error: Invalid Entry")
    end
    it 'should raise an error if value is <= 0' do
      expect { account.deposit(0) }.to raise_error("Error: Invalid Entry")
      expect { account.deposit(-1) }.to raise_error("Error: Invalid Entry")
    end
  end

  describe '#withdraw' do
    it 'should subtract value from balance' do
      account.deposit(100, event)
      account.withdraw(50)
      expect(account.balance).to eq 50
    end
    it 'should raise an error if withdaw will bring account to negative balance' do
      expect { account.withdraw(1) }.to raise_error("Error: Insufficient Funds")
    end
    it 'should raise an error if value is not a number' do
      expect { account.withdraw('hi') }.to raise_error("Error: Invalid Entry")
    end
    it 'should raise an error if value is <= 0' do
      expect { account.withdraw(0) }.to raise_error("Error: Invalid Entry")
      expect { account.withdraw(-1) }.to raise_error("Error: Invalid Entry")
    end
    it 'should create a new Event with negative value, new balance and timestamp' do
      time = Time.now
      Timecop.freeze(time)
      account.deposit(50, event)
      account.withdraw(25, event)
      expect(event).to have_received(:new).with(value: -25, balance: 25, timestamp: time)
    end
    it 'should record deposit event in history array' do
      expect { account.deposit(50, event) }.to change{ account.history.count }.from(0).to(1)
    end
  end
end
