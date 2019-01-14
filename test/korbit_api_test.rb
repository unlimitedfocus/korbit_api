require 'test_helper'

class KorbitApiTest < Minitest::Test
  def setup
    # KorbitApi.configure do |config|
    #   config.access_token = 'test access_token'
    #   config.client_id = 'test client_id'
    #   config.client_secret = 'test client_secret'
    #   config.endpoint = 'test endpoint'
    #   config.user_agent = 'test user_agent'
    #   config.username = 'test_user'
    #   config.password = 'test_password'
    # end
  end

  def test_that_it_has_a_version_0_0_1
    assert_equal '0.0.1', KorbitApi::VERSION
  end

  def test_configuration
    KorbitApi.configuration.reset
    assert_nil KorbitApi.configuration.access_token
    assert_nil KorbitApi.configuration.client_id
    assert_nil KorbitApi.configuration.client_secret
    assert_nil KorbitApi.configuration.username
    assert_nil KorbitApi.configuration.password
    assert_equal KorbitApi::Configuration::DEFAULT_ENDPOINT, KorbitApi.configuration.endpoint
    assert_equal KorbitApi::Configuration::DEFAULT_USER_AGENT, KorbitApi.configuration.user_agent
  end

  # def test_public_api_client
  #   api = KorbitApi.client
  #   assert_instance_of KorbitApi::PublicApi, api
  # end

  # def test_private_api_client
  #   api = KorbitApi.client({
  #   })
  #   assert_instance_of KorbitApi::PrivateApi, api
  # end
end
