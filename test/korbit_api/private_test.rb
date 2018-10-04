require "test_helper"

class PrivateTest < Minitest::Test
  def test_user_info
    api = KorbitApi::Private.new('test_access_token')
    result = api.user_info
    pp result
    # assert result.success?
  end
end
