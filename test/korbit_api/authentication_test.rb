require "test_helper"
require 'pry'

class AuthenticationTest < Minitest::Test
  def test_access_token
    authentication = KorbitApi::Authentication.new('test_key', 'test_secret')
    result = authentication.access_token(
      'test_email',
      'test_password'
    )
    pp result
    # assert result.success?
  end
end
