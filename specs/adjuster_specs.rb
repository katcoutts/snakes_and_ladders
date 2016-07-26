require 'minitest/autorun'
require 'minitest/rg'
require_relative'../adjuster'

class TestAdjuster < MiniTest::Test
  def setup
    @adjuster = Adjuster.new({4 => 6, 6 => -5})
  end

  def test_gives_adjustment
    assert_equal(6, @adjuster.adjustment(4))
  end

  def test_returns_nil_if_no_adjustment
    assert_equal(nil, @adjuster.adjustment(2))
  end


end