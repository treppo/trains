class RoutesDSL
  def initialize(start, destination, max_stops = nil)
    @start = start
    @destination = destination
    @max_stops = max_stops
  end

  def with(stops)
    self.class.new(start, destination, stops)
  end

  def stops
    self
  end

  def max
    (1..max_stops).reduce(0) do |result, count|
      result + start.possible_routes_count(destination, count)
    end
  end

  def exactly
    start.possible_routes_count(destination, max_stops)
  end

  private
  attr_reader :destination, :start, :max_stops
end
