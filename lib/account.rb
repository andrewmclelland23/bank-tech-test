require_relative 'event_log'
require_relative 'printer'

class Account
  attr_reader :balance

  def initialize(printer = Printer, event_log = EventLog.new)
    @balance = 0
    @event_log = event_log
    @printer = printer
  end

  def deposit(value)
    invalid_entry_error unless value.is_a?(Numeric) && value > 0

    @balance += value
    @event_log.add(value: value, balance: @balance, timestamp: Time.now)
  end

  def withdraw(value)
    invalid_entry_error unless value.is_a?(Numeric) && value > 0
    insufficient_fund_error unless @balance >= value

    @balance -= value
    @event_log.add(value: -value, balance: @balance, timestamp: Time.now)
  end

  def statement
    puts @printer.statement(@event_log)
  end

  private

  def insufficient_fund_error
    raise 'Account Error: Insufficient Funds'
  end

  def invalid_entry_error
    raise 'Input Error: Entry must be a number bigger than 0'
  end
end
