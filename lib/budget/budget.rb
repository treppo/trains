# understands a particular account
class Budget
  def initialize(budget)
    @budget = budget
  end

  def exhausted?
    budget == 0
  end

  def overdrawn?
    budget <= 0
  end

  protected

  attr_reader :budget
end
