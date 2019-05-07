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
    @balance < value ? insufficient_fund_error : @balance -= value
  end

  private

  def insufficient_fund_error
    raise "Error: Insufficient Funds"
  end
end
