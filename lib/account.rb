require_relative 'event_log'
require_relative 'print'
require_relative 'input_validation'

# Responsible for managing balance through withdrawals and deposits
class Account

  attr_reader :balance

  def initialize(print: Print, event_log: EventLog.new, iv: InputValidation)
    @balance = 0
    @event_log = event_log
    @print = print
    @input_validation = iv
  end

  def deposit(value)
    @input_validation.deposit(value: value)

    @balance += value
    @event_log.add(value: value, balance: @balance, timestamp: Time.now)
    @print.deposit_message(@balance)
  end

  def withdraw(value)
    @input_validation.withdraw(value: value, balance: @balance)

    @balance -= value
    @event_log.add(value: -value, balance: @balance, timestamp: Time.now)
    @print.withdrawal_message(@balance)
  end

  def statement
    @print.statement(@event_log)
  end
end
