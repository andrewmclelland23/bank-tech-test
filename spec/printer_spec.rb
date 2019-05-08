require 'printer'
require 'timecop'

describe Printer do

  subject(:printer) { described_class }
  let(:account) { double :account }

  before(:each) do
    time = Timecop.freeze(2019, 05, 01, 12)
    @event1 = double :event, value: -100, balance: 2500, timestamp: time
    @event2 = double :event, value: 100, balance: 2700, timestamp: time + 86400
  end


  describe '#statement' do
    it 'should print header for a statement' do
      allow(account).to receive(:history).and_return([])
      expected_result = "date || credit || debit || balance"
      expect(printer.statement(account)).to eq expected_result
    end
    it 'should populate debit column if value in event is negative' do
      allow(account).to receive(:history).and_return([@event1])
      expected_result = ["date || credit || debit || balance",
                         "01/05/2019 || || 100.00 || 2500.00"
                       ].join("\n")
      expect(printer.statement(account)).to eq expected_result
    end
    it 'should populate credit column if value in event is postitive' do
      allow(account).to receive(:history).and_return([@event2])
      expected_result = ["date || credit || debit || balance",
                         "02/05/2019 || 100.00 || || 2700.00"
                       ].join("\n")
      expect(printer.statement(account)).to eq expected_result
    end
    it 'should display events on separate lines and in reverse chronological order' do
      allow(account).to receive(:history).and_return([@event1, @event2])
      expected_result = ["date || credit || debit || balance",
                         "02/05/2019 || 100.00 || || 2700.00",
                         "01/05/2019 || || 100.00 || 2500.00"
                       ].join("\n")
      expect(printer.statement(account)).to eq expected_result
    end
  end
end
