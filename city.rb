require_relative 'link'
require_relative 'route'

# understands the relationship to its neighbors
class City
  UNREACHABLE = Float::INFINITY

  def initialize(name)
    @name = name
    @links = []
  end

  def >>(neighbor_distance_pair)
    links << Link.new(*neighbor_distance_pair)
    neighbor_distance_pair.first
  end

  def distance(*others)
    safe_routes_to(others).distance
  end

  def routes_to(destination, visited_cities = [])
    return [Route.new] if destination == self
    return [] if visited_cities.include?(self)
    links.flat_map {|link| link.routes_to(destination, visited_cities + [self])}
  end

  def to_s
    name
  end

  private

  attr_reader :links, :name

  def safe_routes_to(others)
    routes_to(others.last).find {|route| route.via?(others)}.tap do |route|
      raise ArgumentError.new('NO SUCH ROUTE') unless route
    end
  end
end
