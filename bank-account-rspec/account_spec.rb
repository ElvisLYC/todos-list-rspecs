require "rspec"

require_relative "account"

describe Account do
  let(:acct_number)   { '1234567890' }
  let(:i_acct_number)   { '123490' }
  let(:i_starting_balance) { -1000 }
  let(:starting_balance)   { 1000 }
  let(:new_account)   {Account.new(acct_number, starting_balance)}

  describe "#initialize" do
    context "able to create account with valid input (proper account number)" do
      it "creates a new account" do
          expect(new_account.acct_number).to eq('******7890')
      end
    end

    #unable to create with invalid input
        #invalid account is rejected
        #invalid starting_balance type should be rejected
    context "unable to create account with invalid input" do
      it "raise error if no argument is given" do
        expect { Account.new }.to raise_error(ArgumentError)
      end
      it "invalid account number is rejected" do
        expect { Account.new(i_acct_number) }.to raise_error(InvalidAccountNumberError)
      end
    end
  end

  describe "#transactions" do
    context "initial transaction contains starting balance" do
      it "first transaction equal to starting balance" do
        expect(new_account.transactions[0]).to eq(starting_balance)
      end
    end
  end

  describe "#balance" do
    context "require and integer type argument" do
      it "execute the transaction" do
        expect(new_account.balance).to eq(starting_balance)
        # expect create a transaction and throw the value in to Account
      end
    end
  end

  describe "#acct_number" do #typo?
    context "require valid account number in regex" do
      it "returns the account number of user" do
        expect(new_account.acct_number).to eq("******7890")
      end
    end
  end

  describe "deposit!" do
    let(:transaction_1)   { 2000 }
    let(:transaction_1_invalid)   { -2000 }
    context "require valid deposit amount" do
      it "add deposit amount to balance" do
        expect(new_account.deposit!(transaction_1)).to eq(3000)
      end
    end
    context "unable to deposit transaction amount due to invalid input" do
      it "invalid deposit amount number is rejected" do
        expect { new_account.deposit!(transaction_1_invalid) }.to raise_error(NegativeDepositError)
      end
    end
  end

  describe "#withdraw!" do
    let(:transaction_1_invalid)   { 1001 }
    context "require sufficient balance for valid withdrawal" do
      it "sufficient current balance in the account" do
        expect(new_account.withdraw!(-500)).to eq(500)
      end
    end
    context "unable to withdraw if current balance is less than withdrawal amount" do
      it "withdrawal amount higher than current balance" do
        expect { new_account.withdraw!(transaction_1_invalid) }.to raise_error(OverdraftError)
      end
    end
  end
end
