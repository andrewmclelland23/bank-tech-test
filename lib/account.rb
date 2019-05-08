require_relative 'event'

class Account

  attr_reader :balance, :history

  def initialize
    @balance = 0
    @history = []
  end

  def deposit(value, event = Event)
    @balance += value
    @history << event.new(value: value, balance: @balance, timestamp: Time.now)
  end

  def withdraw(value, event = Event)
    insufficient_fund_error unless @balance >= value

    @balance -= value
    @history << event.new(value: -value, balance: @balance, timestamp: Time.now)
  end

  private

  def insufficient_fund_error
    raise "Error: Insufficient Funds"
  end
end
