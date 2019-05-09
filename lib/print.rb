# Responsible for printing messages
module Print

  STATEMENT_HEADER = 'date || credit || debit || balance'

  def self.statement(event_log)
    statement = event_log.events.map do |event|
      [format_date(event.timestamp), format_credit(event.value),
       format_debit(event.value), format_money(event.balance)].join('|| ')
    end
    puts statement.unshift(STATEMENT_HEADER).join("\n")
  end

  def self.deposit_message(balance)
    puts "Deposit succesful\nBalance: £#{format_money(balance)}"
  end

  def self.withdrawal_message(balance)
    puts "Withdrawal succesful\nBalance: £#{format_money(balance)}"
  end

  def self.format_credit(value)
    format_money(value) + ' ' if value > 0
  end

  def self.format_debit(value)
    format_money(-value) + ' ' if value < 0
  end

  def self.format_date(datetime)
    datetime.strftime('%d/%m/%Y') + ' '
  end

  def self.format_money(value)
    format '%.2f', value
  end

  private_class_method :format_credit, :format_debit,
                       :format_date, :format_money
end
