require 'test_helper'

class KorbitApiTest < Minitest::Test
  def setup
    KorbitApi.configure do |config|
      config.access_token = 'test access_token'
      config.client_id = 'test client_id'
      config.client_secret = 'test client_secret'
      config.endpoint = 'test endpoint'
      config.user_agent = 'test user_agent'
      config.username = 'test_user'
      config.password = 'test_password'
    end
  end

  def test_configuration
    assert_equal 'test access_token', KorbitApi.access_token
    assert_equal 'test client_id', KorbitApi.client_id
    assert_equal 'test client_secret', KorbitApi.client_secret
    assert_equal 'test endpoint', KorbitApi.endpoint
    assert_equal 'test user_agent', KorbitApi.user_agent
    assert_equal 'test_user', KorbitApi.username
    assert_equal 'test_password', KorbitApi.password
  end

  def test_public_api_client
    api = KorbitApi.client
    assert_instance_of KorbitApi::PublicApi, api
  end

  def test_private_api_client
    api = KorbitApi.client({
      access_token: 'test access_token'
    })
    assert_instance_of KorbitApi::PrivateApi, api
  end
end
