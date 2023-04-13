require_relative "../config/sequel"
module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  class Ledger
    def record(expense)
      message = validate(expense)

      return RecordResult.new(false, nil, message) if message

      DB[:expenses].insert(expense)
      id = DB[:expenses].max(:id)
      RecordResult.new(true, id, nil)
    end

    def expenses_on(date)
      DB[:expenses].where(date: date).all
    end

    private

    def validate(expense)
      return "Invalid expense: `payee` is required" unless expense.key?("payee")
      return "Invalid expense: `amount` is required" unless expense.key?("amount")
      return "Invalid expense: `date` is required" unless expense.key?("date")
    end
  end
end
