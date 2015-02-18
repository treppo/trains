require_relative 'link'
require_relative 'route'
require_relative 'routes_dsl'

# understands the relationship to its neighbors
class City
  def initialize(name)
    @name = name
    @links = []
  end

  def >>(neighbor_distance_pair)
    links << Link.new(*neighbor_distance_pair)
    neighbor_distance_pair.first
  end

  def through(*others)
    safe_route_along(others)
  end

  def number_of_routes_to(city)
    RoutesDSL.new(self, city)
  end

  def shortest_route_to(destination)
    shortest_routes(destination).min_by {|route| route.distance}.distance
  end

  def possible_routes(destination, max_stops, visited_cities = [])
    return [Route.new] if destination == self and visited_cities.size == max_stops
    return [] if visited_cities.size == max_stops
    links.flat_map {|link| link.possible_routes(destination, max_stops, visited_cities + [self])}
  end

  def shortest_distance_routes(destination, visited_cities = [])
    return [Route.new] if destination == self
    return [] if visited_cities.include?(self)
    shortest_routes(destination, visited_cities + [self])
  end

  def possible_routes_count(destination, max_stops)
    possible_routes(destination, max_stops).size
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
    possible_routes(others.last, others.size).find {|route| route.via?(others)}
  end

  def shortest_routes(destination, visited_cities = [])
    links.flat_map {|link| link.shortest_distance_routes(destination, visited_cities + [self])}
  end
end
