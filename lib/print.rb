class Print
  def self.statement(event_log)
    statement = event_log.events.map do |event|
      [format_date(event.timestamp), format_credit(event.value),
       format_debit(event.value), format_money(event.balance)
      ].join('|| ')
    end
    puts statement.unshift('date || credit || debit || balance').join("\n")
  end

  def self.deposit_message(balance)
    puts "Deposit succesful\nBalance: £#{format_money(balance)}"
  end

  def self.withdrawal_message(balance)
    puts "Withdrawal succesful\nBalance: £#{format_money(balance)}"
  end

  private

  def self.format_credit(value)
     if value > 0
       format_money(value) + ' '
     else
       nil
     end
  end

  def self.format_debit(value)
    if value < 0
      format_money(-value) + ' '
    else
      nil
    end
  end

  def self.format_date(datetime)
    datetime.strftime('%d/%m/%Y') + ' '
  end

  def self.format_money(value)
    format '%.2f', value
  end
end
