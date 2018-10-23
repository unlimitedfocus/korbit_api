require 'test_helper'

class PrivateApiTest < Minitest::Test
  def setup
    @key = '6vyau0PkgSYtCRSnsXGjmum94XZcUukFkNCYvqbc9VRhITLRaV4cNvnov0yao'
    @secret = 'ETnJhnuY6e46icSamzyU2yxxRGVO1Xeo2pc0luJU5tAL65Je2Zs5gjwBGsPmi'
    @username = 'luke@korbit.co.kr'
    @password = 'qwer123456'
    @authentication = KorbitApi::Authentication.new(@key, @secret)
    tokens = @authentication.access_token(@username, @password)
    @access_token = tokens['access_token']
    @private_api = KorbitApi::PrivateApi.new(@access_token)
  end

  def test_private_api
    refute_nil @private_api
    assert_equal @access_token, @private_api.access_token
  end

  def test_authorization_headers
    assert_equal "Bearer #{@access_token}", @private_api.authorization_headers[:Authorization]
  end

  def test_user_info
    result = @private_api.user_info

    assert result.success?
    expected_keys = %i(email name phone birthday gender userLevel nameCheckedAt prefs)
    assert expected_keys.all? { |key| result.keys } unless result.empty?
  end

  def test_orders_buys
    ticker = KorbitApi::PublicApi.ticker
    amount = 1
    price = ticker['last'].to_f
    result = @private_api.orders_buy('btc_krw', 'limit', amount, price, amount * price)
    binding.pry
  end
end
