require 'test_helper'

class PublicApiTest < Minitest::Test
  def test_ticker
    result = KorbitApi::PublicApi.ticker
    refute_nil result

    expected_keys = %i(timestamp last)
    assert expected_keys.all? { |key| result.keys }
  end

  def test_constants
    result = KorbitApi::PublicApi.constants
    refute_nil result
    refute_nil result['exchange']
    refute_nil result['exchange']['btc_krw']

    expected_nested_keys = %i(tick_size min_price max_price order_min_size order_max_size)
    assert expected_nested_keys.all? { |key| result['exchange']['btc_krw'].keys }
  end

  def test_ticker_detailed
    result = KorbitApi::PublicApi.ticker_detailed
    refute_nil result

    expected_keys = %i(timestamp last bid ask low high volume change changePercent)
    assert expected_keys.all? { |key| result.keys }
  end
  
  def test_orderbook
    result = KorbitApi::PublicApi.orderbook
    refute_nil result

    expected_keys = %i(timestamp bids asks)
    assert expected_keys.all? { |key| result.keys }
  end
  
  def test_transactions
    result = KorbitApi::PublicApi.orderbook
    refute_nil result

    expected_keys = %i(timestamp bids asks)
    assert expected_keys.all? { |key| result.keys }
  end
end
