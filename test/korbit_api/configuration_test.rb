require 'test_helper'

class ConfigurationTest < Minitest::Test
  def test_url
    assert_equal "#{KorbitApi::BASE_URL}/#{KorbitApi::API_VERSION}", KorbitApi.base_url
  end
end
