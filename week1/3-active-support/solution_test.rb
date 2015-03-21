require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  def test_object_blank
    assert_equal [].blank?, true
    assert_equal ''.blank?, true
    assert_equal " \t\n".blank?, true
    assert_equal nil.blank?, true
    assert_equal false.blank?, true
    hash = {}
    assert_equal hash.blank?, true
  end

  def test_object_present
    assert_equal [].present?, false
    assert_equal ''.present?, false
    assert_equal " \t\n".present?, false
    assert_equal nil.present?, false
    assert_equal false.present?, false
    hash = {}
    assert_equal hash.present?, false
  end

  def test_object_presence
    assert_equal [].presence, nil
    assert_equal [2].presence, [2]
  end

  def test_object_try
    arr = [2]
    result = arr.try(:pop)
    assert_equal result, 2
    result = nil.try(:pop)
    assert_equal result, nil
  end

  def test_object_try_with_block
    # test with block
    arr, result = [2], nil
    arr.try { |a| result = a.pop }
    assert_equal result, 2

    # test with block + implicit self
    arr, result = [2], nil
    arr.try { result = pop }
    assert_equal result, 2

    # test with nil object and block
    arr, result = nil, 'not_nil'
    arr.try { result = pop }
    assert_equal result, 'not_nil'
  end

  def test_string_inquirer
    s = StringInquirer.new 'production'
    assert_equal s.production?, true
    assert_equal s.development?, false
  end

  def test_string_with_string_inquirer
    assert_equal 'production'.inquiry.production?, true
    assert_equal 'active'.inquiry.inactive?, false
  end
end
