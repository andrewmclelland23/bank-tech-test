require 'event_log.rb'

describe EventLog do
  let(:event) { double :Event, new: 'something' }
  subject(:event_log) { described_class.new(event) }

  it 'should have events attribute set to [] when initialised' do
    expect(event_log.events).to eq []
  end

  describe '#add' do
    it 'should call new on the Event class with value, timestamp and balance' do
      time = Time.now
      event_log.add(value: 10, balance: 100, timestamp: time)
      expect(event).to have_received(:new)
        .with(value: 10, balance: 100, timestamp: time)
    end
  end
end
