require_relative 'connection'
require_relative 'route'
require_relative 'routes_dsl'
require_relative 'budget/stops'
require_relative 'budget/distance'

# understands the relationship to its neighbors
class City
  def initialize(name)
    @name = name
    @links = []
  end

  def >>(neighbor_distance_pair)
    links << Connection.new(*neighbor_distance_pair)
    neighbor_distance_pair.first
  end

  def distance_through(*others)
    safe_route_along(others).distance
  end

  def number_of_routes_to(city)
    RoutesDSL.new(self, city)
  end

  def routes_count(destination, budget_type, range)
    range.reduce(0) do |result, max_budget|
      result + budget_routes(destination, budget_type.new(max_budget)).size
    end
  end

  def shortest_distance_to(destination)
    shortest_sub_routes(destination).min_by {|route| route.distance}.distance
  end

  def budget_routes(destination, budget)
    return [Route.new] if destination == self and budget.exhausted?
    return [] if budget.overdrawn?
    links.flat_map {|link| link.budget_routes(destination, budget)}
  end

  def shortest_routes(destination, visited_cities = [])
    return [Route.new] if destination == self
    return [] if visited_cities.include?(self)
    shortest_sub_routes(destination, visited_cities)
  end

  def to_s
    name
  end

  private

  attr_reader :links, :name

  def safe_route_along(others)
    route_along(others).tap do |route|
      raise ArgumentError.new('NO SUCH ROUTE') unless route
    end
  end

  def route_along(others)
    budget_routes(others.last, StopsBudget.new(others.size)).find {|route| route.via?(others)}
  end

  def shortest_sub_routes(destination, visited_cities = [])
    links.flat_map {|link| link.shortest_routes(destination, visited_cities + [self])}
  end
end
