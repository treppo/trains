# knows the relationship to its neighbors
class City
  def initialize
    @links = []
  end

  def >>(neighbor_distance_pair)
    links << Link.new(*neighbor_distance_pair)
    neighbor_distance_pair.first
  end

  def distance(*others)
    links.map {|link| link.distance(others) }.min
  end

  private

  attr_reader :links
end

class Link
  UNREACHABLE = Float::INFINITY

  attr_reader :to

  def initialize(to, _distance)
    @to = to
    @_distance = _distance
  end

  def distance(cities)
    return UNREACHABLE if cities.empty?
    return _distance if cities.last == to
    _distance + cities.first.distance(*cities.drop(1))
  end

  private

  attr_reader :_distance
end
