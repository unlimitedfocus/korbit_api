require 'test_helper'

class PrivateApiTest < Minitest::Test
  def setup
    @access_token = nil
    @client_id = ENV['CLIENT_ID']
    @client_secret = ENV['CLIENT_SECRET']
    @username = ENV['USERNAME']
    @password = ENV['PASSWORD']
    @user_agent = ENV['USER_AGENT'] || 'testagent'
    @endpoint = ENV['BASE_URL'].nil? ? KorbitApi::Configuration::DEFAULT_ENDPOINT : "#{ENV['BASE_URL']}/v1"
    
    @authorization = KorbitApi::Authorization.new(@client_id, @client_secret, @username, @password, @user_agent, @endpoint)
    @access_token = @authorization.get_access_token unless @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
    @api = KorbitApi::PrivateApi.new(@access_token, @endpoint, @user_agent)
  end

  def test_private_api
    assert_instance_of KorbitApi::PrivateApi, @api
  end

  def test_user_info
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
    result = @api.user_info

    expected_keys = %i(email name phone birthday gender userLevel)
    assert expected_keys.all? { |key| result.keys }
  end

  def test_user_info
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
    result = @api.user_balances

    assert 0 < result.keys.size
    expected_keys = %i(available trade_in_use withdrawal_in_use)
    first_key = result.keys.first
    assert expected_keys.all? { |key| result[first_key].keys }
  end

  def test_user_balances
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
    constants = @api.constants
    balances_currencies = @api.user_balances.keys

    currencies = constants['exchange'].keys.map {|name| name.split('_').first}
    assert currencies.all? { |key| balances_currencies.include? key }
  end

  def test_orders_buy_limit
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
    balances = @api.user_balances
    selected_currency = balances.find {|_, v| v['available'].to_i > 0}
    market = "#{selected_currency.first}_krw"
    order_min_size = @api.constants['exchange'][market]['order_min_size']
    # orderable = balances['krw']

    best_ask = @api.orderbook['asks'].first
    price, amount = best_ask[0].to_f, 10020 / best_ask[0].to_f
    amount = order_min_size if amount < order_min_size
    result = @api.orders_buy(market, 'limit', amount, price)
    assert_equal 'success', result['status']
  end

  def test_orders_buy_market
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
    balances = @api.user_balances
    selected_currency = balances.find {|_, v| v['available'].to_i > 0}
    market = "#{selected_currency.first}_krw"
    order_min_size = @api.constants['exchange'][market]['order_min_size']

    best_ask = @api.orderbook['asks'].first
    amount = 5000
    result = @api.orders_buy(market, 'market', amount)
    assert_equal 'success', result['status']
  end

  def test_orders_sell_limit
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
    balances = @api.user_balances
    orderable = balances.find {|_, v| v['available'].to_i > 0}
    market = "#{orderable.first}_krw"
    order_min_size = @api.constants['exchange'][market]['order_min_size']

    best_bid = @api.orderbook(market)['bids'].first
    price, amount = best_bid[0].to_f, best_bid[1].to_f
    amount = order_min_size if amount < order_min_size
    result = @api.orders_sell(market, 'limit', amount, price)
    assert_equal 'success', result['status']
  end

  def test_orders_sell_market
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
    balances = @api.user_balances
    orderable = balances.find {|_, v| v['available'].to_i > 0}
    market = "#{orderable.first}_krw"
    order_min_size = @api.constants['exchange'][market]['order_min_size']

    amount = order_min_size
    result = @api.orders_sell(market, 'market', amount)
    assert_equal 'success', result['status']
  end

  def test_orders_cancel
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
    balances = @api.user_balances
    orderable = balances.find {|_, v| v['available'].to_i > 0}
    market = "#{orderable.first}_krw"
    order_min_size = @api.constants['exchange'][market]['order_min_size']

    best_bid = @api.orderbook(market)['bids'].first
    price, amount = best_bid[0].to_f, best_bid[1].to_f

    buy_order = @api.orders_buy(market, 'limit', amount, price)
    assert_equal 'success', buy_order['status']

    result = @api.orders_cancel(market, buy_order['orderId'])
    assert_equal 'success', result.first['status']
  end

  def test_list_orders_open
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
    balances = @api.user_balances
    orderable = balances.find {|_, v| v['available'].to_i > 0}
    market = "#{orderable.first}_krw"

    best_bid = @api.orderbook(market)['bids'].first
    price, amount = best_bid[0].to_f, best_bid[1].to_f
    buy_order = @api.orders_buy(market, 'limit', amount, price)
    assert_equal 'success', buy_order['status']

    result = @api.orders_open(market)
    assert_equal buy_order['orderId'].to_s, result.first['id'].to_s
  end

  # TODO: test
  def test_orders
  end

  # TODO: test
  def test_user_transfers
  end

  # TODO: test
  def test_user_volume
  end

  # TODO: test
  def test_user_accounts
  end

  # TODO: test
  def test_coins_address_assign
  end

  # TODO: test
  def test_coins_withdrawal
  end

  # TODO: test
  def test_coins_status
  end

  # TODO: test
  def coins_withdrawal_cancel
  end


  # TODO: test
  def test_broker_currencies
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
  end

  # TODO: test
  def test_borker_orderbooks
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
  end

  # TODO: test
  def test_broker_orders
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
  end

  # TODO: test
  def test_broker_trades
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
  end

  # TODO: test
  def test_place_broker_orders
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
  end


  # public api

  def test_ticker
    result = @api.ticker
    refute_nil result

    expected_keys = %i(timestamp last)
    assert expected_keys.all? { |key| result.keys }
  end

  def test_constants
    result = @api.constants
    refute_nil result
    refute_nil result['exchange']
    refute_nil result['exchange']['btc_krw']

    expected_nested_keys = %i(tick_size min_price max_price order_min_size order_max_size)
    assert expected_nested_keys.all? { |key| result['exchange']['btc_krw'].keys }
  end

  def test_ticker_detailed
    result = @api.ticker_detailed
    refute_nil result

    expected_keys = %i(timestamp last bid ask low high volume change changePercent)
    assert expected_keys.all? { |key| result.keys }
  end
  
  def test_orderbook
    result = @api.orderbook
    refute_nil result

    expected_keys = %i(timestamp bids asks)
    assert expected_keys.all? { |key| result.keys }
  end
  
  def test_transactions
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT

    result = @api.transactions
    refute_nil result

    expected_keys = %i(timestamp tid price amount)
    assert expected_keys.all? { |key| result.first.keys }
  end
  
  def test_transactions_with_day
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT

    result = @api.transactions('btc_krw', 'day')
    refute_nil result

    expected_keys = %i(timestamp tid price amount)
    assert expected_keys.all? { |key| result.first.keys }
  end
  
  def test_transactions_with_hour
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT

    result = @api.transactions('btc_krw', 'hour')
    refute_nil result

    expected_keys = %i(timestamp tid price amount)
    assert expected_keys.all? { |key| result.first.keys }
  end
  
  def test_transactions_with_minute
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT

    result = @api.transactions('btc_krw', 'minute')
    refute_nil result

    expected_keys = %i(timestamp tid price amount)
    assert expected_keys.all? { |key| result.first.keys }
  end
end
