require 'minitest/pride'
require 'minitest/autorun'
require_relative 'city'

class TrainsTest < MiniTest::Test
  ('A'..'E').each { |name| const_set(name.to_sym, City.new(name)) }
  A >> [B, 5] >> [C, 4] >> [D, 8] >> [E, 6]
  D >> [C, 8]
  A >> [D, 5]
  C >> [E, 2]
  E >> [B, 3]
  A >> [E, 7]

  def test_distance
    assert_equal 9, A.distance(B, C)
    assert_equal 5, A.distance(D)
    assert_equal 13, A.distance(D, C)
    assert_equal 22, A.distance(E, B, C, D)
  end

  def test_impossible_route
    err = assert_raises(ArgumentError) { A.distance(E, D) }
    assert_equal 'NO SUCH ROUTE', err.message
  end
end
