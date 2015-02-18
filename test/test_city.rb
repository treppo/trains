require 'minitest/pride'
require 'minitest/autorun'
require_relative '../lib/city'

class CityTest < MiniTest::Test
  ('A'..'E').each { |name| const_set(name.to_sym, City.new(name)) }
  A >> [B, 5] >> [C, 4] >> [D, 8] >> [E, 6]
  D >> [C, 8]
  A >> [D, 5]
  C >> [E, 2]
  E >> [B, 3]
  A >> [E, 7]

  def test_distance
    assert_equal 9, A.through(B, C).distance
    assert_equal 5, A.through(D).distance
    assert_equal 13, A.through(D, C).distance
    assert_equal 22, A.through(E, B, C, D).distance
  end

  def test_impossible_route
    err = assert_raises(ArgumentError) { A.through(E, D).distance }
    assert_equal 'NO SUCH ROUTE', err.message
  end

  def test_number_of_trips
    assert_equal 2, C.number_of_routes_to(C).with(3).stops.max
    assert_equal 3, A.number_of_routes_to(C).with(4).stops.exactly
  end

  def test_shortest_route
    assert_equal 9, A.shortest_route_to(C)
    assert_equal 9, B.shortest_route_to(B)
  end
end
