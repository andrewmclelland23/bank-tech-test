require 'account'

describe 'Acceptance Criteria for Bank app' do
  it 'should print a correct statement after deposits and withdrawals' do
    account = Account.new
    account.deposit(1000)
    account.deposit(2000)
    account.withdraw(500)
    expected_result = "date || credit || debit || balance\n14/01/2012 || || 500.00 || 2500.00\n13/01/2012 || 2000.00 || || 3000.00\n10/01/2012 || 1000.00 || || 1000.00"
    expect (account.statement).to eq expected_result
  end
end
