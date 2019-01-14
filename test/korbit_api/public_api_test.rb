require 'test_helper'

class PublicApiTest < Minitest::Test
  def setup
    @api = KorbitApi::PublicApi.new
  end

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
    return

    result = @api.transactions
    refute_nil result

    expected_keys = %i(timestamp tid price amount)
    assert expected_keys.all? { |key| result.first.keys }
  end
  
  def test_transactions_with_day
    return

    result = @api.transactions('btc_krw', 'day')
    refute_nil result

    expected_keys = %i(timestamp tid price amount)
    assert expected_keys.all? { |key| result.first.keys }
  end
  
  def test_transactions_with_hour
    return

    result = @api.transactions('btc_krw', 'hour')
    refute_nil result

    expected_keys = %i(timestamp tid price amount)
    assert expected_keys.all? { |key| result.first.keys }
  end
  
  def test_transactions_with_minute
    return

    result = @api.transactions('btc_krw', 'minute')
    refute_nil result

    expected_keys = %i(timestamp tid price amount)
    assert expected_keys.all? { |key| result.first.keys }
  end
end
