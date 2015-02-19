require_relative 'budget'

class StopsBudget < Budget
  def -(_)
    self.class.new(budget - 1)
  end
end
