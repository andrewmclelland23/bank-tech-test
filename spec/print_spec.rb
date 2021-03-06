require 'print'
require 'timecop'

describe Print do
  subject(:print) { described_class }
  let(:event_log) { double :event_log }

  before(:each) do
    time = Timecop.freeze(2019, 0o5, 0o1, 12)
    @event1 = double :event, value: -100, balance: 2500, timestamp: time
    @event2 = double :event, value: 100, balance: 2700, timestamp: time + 86_400
    @event3 = double :event, value: 25.27, balance: 276.13, timestamp: time
  end

  describe '#statement' do
    it 'should print header for a statement' do
      allow(event_log).to receive(:events).and_return([])
      expected_result = "date || credit || debit || balance\n"
      expect { print.statement(event_log) }.to output(expected_result).to_stdout
    end
    it 'should populate debit column if value in event is negative' do
      allow(event_log).to receive(:events).and_return([@event1])
      expected_result = ['date || credit || debit || balance',
                         "01/05/2019 || || 100.00 || 2500.00\n"].join("\n")
      expect { print.statement(event_log) }.to output(expected_result).to_stdout
    end
    it 'should populate credit column if value in event is postitive' do
      allow(event_log).to receive(:events).and_return([@event2])
      expected_result = ['date || credit || debit || balance',
                         "02/05/2019 || 100.00 || || 2700.00\n"].join("\n")
      expect { print.statement(event_log) }.to output(expected_result).to_stdout
    end
    it 'should display events on separate lines' do
      allow(event_log).to receive(:events).and_return([@event2, @event1])
      expected_result = ['date || credit || debit || balance',
                         '02/05/2019 || 100.00 || || 2700.00',
                         "01/05/2019 || || 100.00 || 2500.00\n"].join("\n")
      expect { print.statement(event_log) }.to output(expected_result).to_stdout
    end
    it 'should show decimals correctly' do
      allow(event_log).to receive(:events).and_return([@event3])
      expected_result = ['date || credit || debit || balance',
                         "01/05/2019 || 25.27 || || 276.13\n"].join("\n")
      expect { print.statement(event_log) }.to output(expected_result).to_stdout
    end
  end

  describe '#deposit_message' do
    it 'should return formatted message when called with a balance' do
      expect { print.deposit_message(50) }
        .to output("Deposit succesful\nBalance: £50.00\n").to_stdout
    end
  end
  describe '#withdrawal_message' do
    it 'should return formatted message when called with a balance' do
      expect { print.withdrawal_message(25.23) }
        .to output("Withdrawal succesful\nBalance: £25.23\n").to_stdout
    end
  end
end
