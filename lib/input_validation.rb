module InputValidation

  def self.deposit(value:)
    invalid_entry_error unless value.is_a?(Numeric) && value > 0
  end

  def self.withdraw(value:, balance:)
    invalid_entry_error unless value.is_a?(Numeric) && value > 0
    insufficient_fund_error unless balance >= value
  end

  # Private methods below

  def self.insufficient_fund_error
    raise 'Input Error: Insufficient Funds'
  end

  def self.invalid_entry_error
    raise 'Input Error: Entry must be a number bigger than 0'
  end

  private_class_method :insufficient_fund_error, :invalid_entry_error

end
