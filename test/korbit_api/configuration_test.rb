require 'test_helper'

class ConfigurationTest < Minitest::Test
  def setup
    @configuration = KorbitApi::Configuration
  end

  def test_extended
    @configuration_new = "".extend KorbitApi::Configuration
    assert_nil @configuration_new.access_token
    assert_nil @configuration_new.client_id
    assert_nil @configuration_new.client_secret
    assert_nil @configuration_new.username
    assert_nil @configuration_new.password
    assert_equal 'https://api.korbit.co.kr/v1', @configuration_new.endpoint
    assert_equal "Korbit API Ruby Gem #{KorbitApi::VERSION}", @configuration_new.user_agent
  end
end
