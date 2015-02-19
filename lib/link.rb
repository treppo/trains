# knows the connection between cities
class Link
  def initialize(target, distance)
    @target = target
    @distance = distance
  end

  def shortest_routes(destination, visited_cities)
    target.shortest_routes(destination, visited_cities).map(&method(:prepend_distance))
  end

  def budget_routes(destination, budget)
    target.budget_routes(destination, budget - distance).map(&method(:prepend_distance))
  end

  private

  attr_reader :distance, :target

  def prepend_distance(route)
    route.prepend(target, distance)
  end
end
