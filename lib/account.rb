require_relative 'event'

class Account

  attr_reader :balance, :history

  def initialize
    @balance = 0
    @history = []
  end

  def deposit(value, event = Event)
    invalid_entry_error unless value.is_a?(Numeric) && value > 0
    @balance += value
    @history << event.new(value: value, balance: @balance, timestamp: Time.now)
  end

  def withdraw(value, event = Event)
    invalid_entry_error unless value.is_a?(Numeric) && value > 0
    insufficient_fund_error unless @balance >= value

    @balance -= value
    @history << event.new(value: -value, balance: @balance, timestamp: Time.now)
  end

  private

  def insufficient_fund_error
    raise "Error: Insufficient Funds"
  end

  def invalid_entry_error
    raise "Error: Invalid Entry"
  end
end
