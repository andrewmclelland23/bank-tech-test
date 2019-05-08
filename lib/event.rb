class Event
  attr_reader :value, :balance, :timestamp

  def initialize(value:, balance:, timestamp:)
    @value = value
    @timestamp = timestamp
    @balance = balance
  end
end
