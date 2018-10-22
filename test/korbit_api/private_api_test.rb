require 'test_helper'

class PrivateApiTest < Minitest::Test
  def setup
    @access_token = 'test_token'
    @private_api = KorbitApi::PrivateApi.new(@access_token)
  end

  def test_private_api
    refute_nil @private_api
    assert_equal @access_token, @private_api.access_token
  end

  def test_authorization_headers
    assert_equal "Bearer #{@access_token}", @private_api.authorization_headers[:Authorization]
  end
end
