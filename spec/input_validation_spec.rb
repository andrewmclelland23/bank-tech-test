require 'input_validation'

describe InputValidation do
  subject(:input_validation) { described_class }

  describe '#deposit' do
    it 'should raise invalid input error if given value is not a number' do
      expect { input_validation.deposit(value: 'test') }
        .to raise_error 'Input Error: Entry must be a number bigger than 0'
    end
    it 'should raise invalid input error if given value == 0' do
      expect { input_validation.deposit(value: 0) }
        .to raise_error 'Input Error: Entry must be a number bigger than 0'
    end
    it 'should raise invalid input error if given value < 0' do
      expect { input_validation.deposit(value: -1) }
        .to raise_error 'Input Error: Entry must be a number bigger than 0'
    end
    it 'should not raise invalid input error if given value > 0' do
      expect { input_validation.deposit(value: 1) }
        .to_not raise_error 'Input Error: Entry must be a number bigger than 0'
    end
  end

  describe '#withdraw' do
    it 'should raise invalid input error if given value is not a number' do
      expect { input_validation.withdraw(value: 'test', balance: 50) }
        .to raise_error 'Input Error: Entry must be a number bigger than 0'
    end
    it 'should raise invalid input error if given value == 0' do
      expect { input_validation.withdraw(value: 0, balance: 50) }
        .to raise_error 'Input Error: Entry must be a number bigger than 0'
    end
    it 'should raise invalid input error if given value < 0' do
      expect { input_validation.withdraw(value: -1, balance: 50) }
        .to raise_error 'Input Error: Entry must be a number bigger than 0'
    end
    it 'should not raise invalid input error if given value > 0' do
      expect { input_validation.withdraw(value: 1, balance: 50) }
        .to_not raise_error 'Input Error: Entry must be a number bigger than 0'
    end
    it 'should raise insufficient fund error if value > balance' do
      expect { input_validation.withdraw(value: 5, balance: 4) }
        .to raise_error 'Input Error: Insufficient Funds'
    end
    it 'should not raise insufficient fund error if value == balance' do
      expect { input_validation.withdraw(value: 5, balance: 5) }
        .to_not raise_error 'Input Error: Insufficient Funds'
    end
    it 'should not raise insufficient fund error if value < balance' do
      expect { input_validation.withdraw(value: 4, balance: 5) }
        .to_not raise_error 'Input Error: Insufficient Funds'
    end
  end
end
