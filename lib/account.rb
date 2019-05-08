require 'timecop'

class Account

  attr_reader :balance, :history

  def initialize
    @balance = 0
    @history = []
  end

  def deposit(value, event = Event.new)
    @balance += value
    @history << event.create(value, Time.now)
  end

  def withdraw(value)
    @balance < value ? insufficient_fund_error : @balance -= value
  end

  private

  def insufficient_fund_error
    raise "Error: Insufficient Funds"
  end
end
