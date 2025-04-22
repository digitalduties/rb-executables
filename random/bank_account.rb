class BankAccount
    attr_reader :name, :balance, :history
  
    def initialize(name, initial_deposit = 0)
      @name = name
      @balance = initial_deposit
      @history = []
      @history << "Account opened with $#{initial_deposit}" if initial_deposit > 0
    end
  
    def deposit(amount)
      return "Invalid amount" if amount <= 0
  
      @balance += amount
      @history << "Deposited $#{amount}"
      @balance
    end
  
    def withdraw(amount)
      return "Invalid amount" if amount <= 0
  
      if @balance < amount
        @history << "Attempted to withdraw $#{amount} - Insufficient funds"
        return "Insufficient funds"
      end
  
      @balance -= amount
      @history << "Withdrew $#{amount}"
      @balance
    end
  end
  
account = BankAccount.new("Pau", 20)
puts account.deposit(50) 
puts account.withdraw(30)
puts account.withdraw(100)
puts account.balance
puts account.history