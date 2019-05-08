require_relative 'event'
require_relative 'printer'

class Account
  attr_reader :balance, :history

  def initialize(printer = Printer)
    @balance = 0
    @history = []
    @printer = printer
  end

  def deposit(value, event = Event)
    invalid_entry_error unless value.is_a?(Numeric) && value > 0

    @balance += value
    new_event = event.new(value: value, balance: @balance, timestamp: Time.now)
    @history.unshift new_event
  end

  def withdraw(value, event = Event)
    invalid_entry_error unless value.is_a?(Numeric) && value > 0
    insufficient_fund_error unless @balance >= value

    @balance -= value
    new_event = event.new(value: -value, balance: @balance, timestamp: Time.now)
    @history.unshift new_event
  end

  def statement
    puts @printer.statement(self)
  end

  private

  def insufficient_fund_error
    raise 'Account Error: Insufficient Funds'
  end

  def invalid_entry_error
    raise 'Input Error: Entry must be a number bigger than 0'
  end
end
