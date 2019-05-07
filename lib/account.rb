class Account

  attr_reader :balance, :history

  def initialize
    @balance = 0
    @history = []
  end

  def deposit(value)
    @balance += value
  end

  def withdraw(value)
    @balance -= value
  end
end
