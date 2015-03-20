require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_raises_error_when_enum_doesnt_exist
    assert_raises(NoMethodError) do
      Enums.non_existent
    end
  end

  def test_can_access_enum_value
    assert_equal Enums.direction.west, :west
  end

  def test_enum_is_enumerable
    assert_kind_of Enumerator, Enums.direction.each
  end
end
