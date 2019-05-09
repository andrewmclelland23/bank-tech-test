require 'account'
require 'timecop'

describe Account do
  let(:event_log) { double :event_log, add: 'something' }
  let(:print) { double :print,
                       statement: 'Stand in for statement',
                       deposit_message: 'test deposit message',
                       withdrawal_message: 'test withdrawal message'
              }
  let(:iv) { double :input_validation, deposit: 'err', withdraw: 'err'}
  subject(:account) { described_class.new(print: print, event_log: event_log,
                                          iv: iv) }

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
    it 'should call input_validation.deposit' do
      account.deposit(5)
      expect(iv).to have_received(:deposit).with(value: 5)
    end
    it 'should accept decimals' do
      account.deposit(125.75)
      expect(account.balance).to eq 125.75
    end
    it 'should call deposit_message on print with new balance' do
      account.deposit(20)
      expect(print).to have_received(:deposit_message).with(20)
    end
  end

  describe '#withdraw' do
    it 'should subtract value from balance' do
      account.deposit(100)
      account.withdraw(50)
      expect(account.balance).to eq 50
    end
    it 'should call input_validation.withdraw' do
      account.withdraw(5)
      expect(iv).to have_received(:withdraw).with(value: 5, balance: 0)
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
    it 'should call withdrawal_message on print with new balance' do
      account.deposit(100)
      account.withdraw(20)
      expect(print).to have_received(:withdrawal_message).with(80)
    end
  end

  describe '#statement' do
    it 'should call Printer.statement method with event_log as argument' do
      account.statement
      expect(print).to have_received(:statement).with(event_log)
    end
  end
end
