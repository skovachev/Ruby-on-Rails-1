require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_the_truth
    expected_table =
        [[0, 1], [1, 2], [2, 5], [0, 6], nil, [1, 3], [3, 7], [3, 4]]

    input_matrix =
        [[1, nil, nil, nil],
         [nil, 2, 5, nil],
         [6, nil, nil, 7],
         [nil, 3, nil, 4]]

    resulting_table = input_matrix.compress

    assert_equal expected_table, resulting_table
  end
end
