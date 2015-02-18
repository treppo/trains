# knows the connection between cities
class Link
  def initialize(target, distance)
    @target = target
    @distance = distance
  end

  def possible_routes(*args)
    target.possible_routes(*args).map {|route| route.prepend(target, distance) }
  end

  def shortest_distance_routes(*args)
    target.shortest_distance_routes(*args).map {|route| route.prepend(target, distance) }
  end

  private

  attr_reader :distance, :target
end
