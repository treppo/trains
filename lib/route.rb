# understands how to go from a city to another
class Route
  attr_reader :distance

  def initialize(stops = [], distance = 0)
    @distance = distance
    @stops = stops
  end

  def prepend(stop, segment_distance)
    Route.new([stop] + stops, distance + segment_distance)
  end

  def via?(cities)
    stops == cities
  end

  def stops_count
    stops.size
  end

  def to_s
    stops.reduce("Start") {|result, stop| result + " -> #{stop}"}
  end

  private
  attr_reader :stops
end
