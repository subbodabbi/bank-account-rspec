require "rspec"

require_relative "account"

describe Account do


  let(:number) { '1234567890' }
  let(:account) {Account.new(number)}
  let(:rich_account) {Account.new(number,10000)}

  describe "#initialize" do

    context "with valid input" do
      it "expects an account with number" do
        expect(account).to be_a_kind_of(Account)
      end

      it "has an account with a default starting balance of 0" do
        expect(account.transactions).to eq [0]
      end

      it "can have an account with a new starting balance" do
        expect(rich_account.transactions).to eq [10000]
      end

    end

    context "with invalid input" do
      
      it "requires an argument" do
        expect { Account.new }.to raise_error(ArgumentError)
      end

      it "expects a valid acct number" do
        expect { Account.new('2345') }.to raise_error(InvalidAccountNumberError)
      end

    end

  end

  describe "#transactions" do

    it "returns an array of transactions" do
      account.deposit!(350)
      expect(account.transactions).to eq [0,350]
    end

  end

  describe "#balance" do

    it "returns the current balance in the bank" do
      account.deposit!(350)
      expect(account.balance).to eq 350
    end

  end

  describe "#account_number" do

    it "returns a hidden account number" do
      expect(account.acct_number).to eq '******7890'
    end

  end

  describe "#deposit!" do

    context "with valid input" do

      it "adds amount into balance" do
        account.deposit!(350)
        expect(account.balance).to eq 350
      end

    end

    context "when negative amount" do
    
      it "raises error" do
        expect {account.deposit!(-350)}.to raise_error(NegativeDepositError)
      end

    end

  end

  describe "#withdraw!" do
      
      it "removes amount from balance when negative amount" do
        rich_account.withdraw!(-350)
        expect(rich_account.balance).to eq 9650
      end

      it "removes amount from balance when positive amount" do
        rich_account.withdraw!(350)
        expect(rich_account.balance).to eq 9650
      end

  end
end