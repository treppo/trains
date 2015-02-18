class Link
  def initialize(target, distance)
    @target = target
    @distance = distance
  end

  def routes_to(destination, visited_cities)
    target.routes_to(destination, visited_cities).map {|route| route.prepend(target, distance) }
  end

  private

  attr_reader :distance, :target
end
