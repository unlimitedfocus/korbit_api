require 'test_helper'

class VersionTest < Minitest::Test
  def test_ticker
    assert_equal '0.0.0', KorbitApi::VERSION
  end
end
