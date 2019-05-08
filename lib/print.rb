class Print
  def self.statement(event_log)
    statement_array = event_log.events.map do |event|
      date = "#{format_date(event.timestamp)} || "
      credit = event.value > 0 ? "#{format_money(event.value)} || " : '|| '
      debit = event.value > 0 ? '|| ' : "#{format_money(-event.value)} || "
      balance = format_money(event.balance)
      date + credit + debit + balance
    end
    puts statement_array.unshift('date || credit || debit || balance').join("\n")
  end

  def self.deposit_message(balance)
    puts "Deposit succesful\nBalance: £#{format_money(balance)}"
  end

  def self.withdrawal_message(balance)
    puts "Withdrawal succesful\nBalance: £#{format_money(balance)}"
  end

  private

  def self.format_date(datetime)
    datetime.strftime('%d/%m/%Y')
  end

  def self.format_money(value)
    format '%.2f', value
  end
end
