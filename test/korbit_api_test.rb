require "test_helper"

class KorbitApiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::KorbitApi::VERSION
  end

  def test_it_does_something_useful
    assert true
  end
end
