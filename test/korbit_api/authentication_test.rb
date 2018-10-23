require 'test_helper'

class AuthenticationTest < Minitest::Test
  def setup
    @key = '6vyau0PkgSYtCRSnsXGjmum94XZcUukFkNCYvqbc9VRhITLRaV4cNvnov0yao'
    @secret = 'ETnJhnuY6e46icSamzyU2yxxRGVO1Xeo2pc0luJU5tAL65Je2Zs5gjwBGsPmi'
    @username = 'luke@korbit.co.kr'
    @password = 'qwer123456'
    @authentication = KorbitApi::Authentication.new(@key, @secret)
  end

  def test_authentication
    assert_equal @key, @authentication.key
    assert_equal @secret, @authentication.secret
  end

  def test_access_token
    result = @authentication.access_token(@username, @password)

    assert result.success?
    expected_keys = %i(token_type access_token refresh_token expires_in)
    assert expected_keys.all? { |key| result.keys } unless result.empty?
  end

  def test_refresh_token
    tokens = @authentication.access_token(@username, @password)
    result = @authentication.refresh_token(tokens['refresh_token'])

    assert result.success?
    expected_keys = %i(token_type access_token refresh_token expires_in)
    assert expected_keys.all? { |key| result.keys } unless result.empty?
  end
end
