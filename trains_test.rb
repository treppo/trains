require 'minitest/autorun'
require_relative 'trains'

class TrainsTest < MiniTest::Test
  ('A'..'E').each { |name| const_set(name.to_sym, City.new) }
  A >> [B, 5] >> [C, 4] >> [D, 8] >> [E, 6]
  A >> [D, 5]

  def test_distance
    assert_equal 9, A.distance(B, C)
    assert_equal 5, A.distance(D)
  end
end
