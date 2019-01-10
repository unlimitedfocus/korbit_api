require 'test_helper'

class PrivateApiTest < Minitest::Test
  def setup
    @options = {
      endpoint: ENV['BASE_URL'].present? ? "#{ENV['BASE_URL']}/v1" : KorbitApi::Configuration::DEFAULT_ENDPOINT
    }
    
    @public_api = KorbitApi::PrivateApi.new(@options)
    @api = KorbitApi.client(@options.merge({
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      username: ENV['USERNAME'],
      password: ENV['PASSWORD']
    }))
  end

  def test_private_api
    assert_instance_of KorbitApi::PrivateApi, @api
  end

  def test_user_info
    return if @options[:endpoint].eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
    result = @api.user_info

    expected_keys = %i(email name phone birthday gender userLevel)
    assert expected_keys.all? { |key| result.keys }
  end

  def test_ticker
    result = @public_api.ticker
    refute_nil result

    expected_keys = %i(timestamp last)
    assert expected_keys.all? { |key| result.keys }
  end

  def test_constants
    result = @public_api.constants
    refute_nil result
    refute_nil result['exchange']
    refute_nil result['exchange']['btc_krw']

    expected_nested_keys = %i(tick_size min_price max_price order_min_size order_max_size)
    assert expected_nested_keys.all? { |key| result['exchange']['btc_krw'].keys }
  end

  def test_ticker_detailed
    result = @public_api.ticker_detailed
    refute_nil result

    expected_keys = %i(timestamp last bid ask low high volume change changePercent)
    assert expected_keys.all? { |key| result.keys }
  end
  
  def test_orderbook
    result = @public_api.orderbook
    refute_nil result

    expected_keys = %i(timestamp bids asks)
    assert expected_keys.all? { |key| result.keys }
  end
  
  # def test_transactions
  #   return if @options[:endpoint].eql? KorbitApi::Configuration::DEFAULT_ENDPOINT

  #   result = @public_api.transactions
  #   refute_nil result

  #   expected_keys = %i(timestamp tid price amount)
  #   assert expected_keys.all? { |key| result.first.keys }
  # end
  
  # def test_transactions_with_day
  #   return if @options[:endpoint].eql? KorbitApi::Configuration::DEFAULT_ENDPOINT

  #   result = @public_api.transactions('btc_krw', 'day')
  #   refute_nil result

  #   expected_keys = %i(timestamp tid price amount)
  #   assert expected_keys.all? { |key| result.first.keys }
  # end
  
  # def test_transactions_with_hour
  #   return if @options[:endpoint].eql? KorbitApi::Configuration::DEFAULT_ENDPOINT

  #   result = @public_api.transactions('btc_krw', 'hour')
  #   refute_nil result

  #   expected_keys = %i(timestamp tid price amount)
  #   assert expected_keys.all? { |key| result.first.keys }
  # end
  
  # def test_transactions_with_minute
  #   return if @options[:endpoint].eql? KorbitApi::Configuration::DEFAULT_ENDPOINT

  #   result = @public_api.transactions('btc_krw', 'minute')
  #   refute_nil result

  #   expected_keys = %i(timestamp tid price amount)
  #   assert expected_keys.all? { |key| result.first.keys }
  # end
end
