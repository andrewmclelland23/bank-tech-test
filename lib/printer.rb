class Printer

  def self.statement(account)
    result = "date || credit || debit || balance"
    account.history.reverse.each do |event|
      if event.value > 0
        result += "\n#{format_date(event.timestamp)} || #{format_money(event.value)} || || #{format_money(event.balance)}"
      else
        result += "\n#{format_date(event.timestamp)} || || #{format_money(-event.value)} || #{format_money(event.balance)}"
      end
    end
    result
  end

  private

  def self.format_date(datetime)
    datetime.strftime('%d/%m/%Y')
  end

  def self.format_money(value)
    sprintf "%.2f", value
  end
end
