require 'account'
require 'timecop'

describe Account do
  let(:event_log) { double :event_log, add: 'something' }
  let(:printer) { double :printer, statement: 'Stand in for statement' }
  subject(:account) { described_class.new(printer, event_log) }

  it 'should have 0 balance when initialised' do
    expect(account.balance).to eq 0
  end

  describe '#deposit' do
    it 'should add value to balance' do
      account.deposit(50)
      expect(account.balance).to eq 50
    end
    it 'should call add @event_log.add method with correct arguments' do
      time = Time.now
      Timecop.freeze(time)
      account.deposit(50)
      expect(event_log).to have_received(:add)
        .with(value: 50, balance: 50, timestamp: time)
    end
    it 'should raise an error if value is not a number' do
      expect { account.deposit('hi') }.to raise_error('Input Error: Entry must be a number bigger than 0')
    end
    it 'should raise an error if value is <= 0' do
      expect { account.deposit(0) }
            .to raise_error('Input Error: Entry must be a number bigger than 0')
      expect { account.deposit(-1) }
            .to raise_error('Input Error: Entry must be a number bigger than 0')
    end
    it 'should accept decimals' do
      account.deposit(125.75)
      expect(account.balance).to eq 125.75
    end
  end

  describe '#withdraw' do
    it 'should subtract value from balance' do
      account.deposit(100)
      account.withdraw(50)
      expect(account.balance).to eq 50
    end
    it 'should raise error if withdaw will bring account to negative balance' do
      expect { account.withdraw(1) }
            .to raise_error('Account Error: Insufficient Funds')
    end
    it 'should raise error if value is not a number' do
      expect { account.withdraw('hi') }
            .to raise_error('Input Error: Entry must be a number bigger than 0')
    end
    it 'should raise an error if value is <= 0' do
      expect { account.withdraw(0) }
            .to raise_error('Input Error: Entry must be a number bigger than 0')
      expect { account.withdraw(-1) }
            .to raise_error('Input Error: Entry must be a number bigger than 0')
    end
    it 'should call add @event_log.add method with correct arguments' do
      time = Time.now
      Timecop.freeze(time)
      account.deposit(50)
      account.withdraw(25)
      expect(event_log).to have_received(:add)
        .with(value: -25, balance: 25, timestamp: time)
    end
    it 'should accept decimals' do
      account.deposit(30)
      account.withdraw(25.25)
      expect(account.balance).to eq 4.75
    end
  end

  describe '#statement' do
    it 'should call the Printer.statement method with the event_log as argument' do
      account.statement
      expect(printer).to have_received(:statement).with(event_log)
    end
    it 'should console log whatever the printer returns' do
      expect { account.statement }.to output("Stand in for statement\n").to_stdout
    end
  end
end
