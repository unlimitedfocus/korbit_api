require 'test_helper'

class KorbitApiTest < Minitest::Test
  def test_version_number
    assert_equal '0.0.0', ::KorbitApi::VERSION
  end
end
