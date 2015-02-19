# provides a convenient language
class RoutesDSL
  def initialize(start, destination, max_stops = nil)
    @start = start
    @destination = destination
    @max_stops = max_stops
  end

  def with(stops)
    self.class.new(start, destination, stops)
  end

  def with_distance_under(max_distance)
    start.routes_count(destination, DistanceBudget, (1..max_distance-1))
  end

  def stops
    self
  end

  def max
    start.routes_count(destination, StopsBudget, (1..max_stops))
  end

  def exactly
    start.routes_count(destination, StopsBudget, (max_stops..max_stops))
  end

  private
  attr_reader :destination, :start, :max_stops
end
