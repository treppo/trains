require_relative 'budget'

class DistanceBudget < Budget
  def -(distance)
    self.class.new(budget - distance)
  end
end
