# Bank Tech Test

A tech test to practice and showcase my methodology and skill in programming in an OO language.

## Technologies
  Language: Ruby
  Test Framework: RSPEC

## Requirements
1) Should be able to interact with code via a REPL like IRB. (You don't need to implement a command line interface that takes input from STDIN.)

2) Deposits, withdrawal.

3) Account statement (date, amount, balance) printing.

4) Data can be kept in memory (it doesn't need to be stored to a database or anything).

## Acceptance criteria

Given a client makes a deposit of 1000 on 10-01-2012  
And a deposit of 2000 on 13-01-2012  
And a withdrawal of 500 on 14-01-2012  
When she prints her bank statement
Then she would see:

>date || credit || debit || balance  
14/01/2012 || || 500.00 || 2500.00  
13/01/2012 || 2000.00 || || 3000.00  
10/01/2012 || 1000.00 || || 1000.0
