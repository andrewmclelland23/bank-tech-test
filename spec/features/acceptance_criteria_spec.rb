require 'account'
require 'timecop'

describe 'Acceptance Criteria for Bank app' do
  it 'should print a correct statement after deposits and withdrawals' do
    Timecop.freeze(2012, 1, 10)
    account = Account.new
    account.deposit(1000)
    Timecop.freeze(2012, 1, 13)
    account.deposit(2000)
    Timecop.freeze(2012, 1, 14)
    account.withdraw(500)
    expected_result = ['date || credit || debit || balance',
                       '14/01/2012 || || 500.00 || 2500.00',
                       '13/01/2012 || 2000.00 || || 3000.00',
                       "10/01/2012 || 1000.00 || || 1000.00\n"].join("\n")
    expect { account.statement }.to output(expected_result).to_stdout
  end
end
