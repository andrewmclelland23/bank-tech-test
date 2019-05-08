require 'event'
require 'timecop'

describe Event do
  it 'should set timestamp attribute when initialized' do
    time = Time.now
    Timecop.freeze(time)
    event = Event.new(value: -50, balance: -50, timestamp: time)
    expect(event.timestamp).to eq time
  end
  it 'should set value attribute when initialized' do
    event = Event.new(value: 50, balance: 50, timestamp: Time.now)
    expect(event.value).to eq 50
  end
  it 'should set balance attribute when initialized' do
    event = Event.new(value: 50, balance: 50, timestamp: Time.now)
    expect(event.balance).to eq 50
  end
end
