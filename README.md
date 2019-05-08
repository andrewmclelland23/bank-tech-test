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

## Setup

Follow these steps:

1. Clone/fork this repo
2. If you don't have ruby, use [this guide](https://www.ruby-lang.org/en/documentation/installation/) to install it.
3. If you don't have bundler, run `gem install bundler`
4. Navigate to the project directory and run `bundle install`

## How to run the program

First make sure you've peformed the [setup](#setup), then follow these steps:

1. From the project root run `irb -r './lib/account.rb'`
2. Create a new account `account = Account.new`
3. Play arround with making deposits and withrawals
```
account.deposit(200)
account.withdraw(150)
account.withdraw(20)
```
4. Try printing a statement with `account.statement`

## Running the tests

First make sure you've peformed the [setup](#setup), then follow these steps:

1. From the project root run `rspec`

