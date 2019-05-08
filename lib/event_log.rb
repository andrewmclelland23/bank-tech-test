require_relative 'event'

class EventLog

  attr_reader :events

  def initialize(event = Event)
    @events = []
    @event = event
  end

  def add(value:, balance:, timestamp:)
    new_event = @event.new(value: value, balance: balance, timestamp: timestamp)
    @events.unshift new_event
  end

end
