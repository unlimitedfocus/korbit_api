require "test_helper"

class PublicTest < Minitest::Test
  def test_constants
    result = KorbitApi::Public.constants
    # pp result
    assert result.success?
    refute_nil result
  end

  def test_ticker
    result = KorbitApi::Public.ticker
    # pp result
    assert result.success?
    refute_nil result
  end

  def test_ticker_detailed
    result = KorbitApi::Public.ticker_detailed('btc_krw')
    # pp result
    assert result.success?
    refute_nil result
  end

  def test_orderbook
    result = KorbitApi::Public.orderbook('btc_krw')
    # pp result
    assert result.success?
    refute_nil result
  end

  def test_transactions
    result = KorbitApi::Public.transactions('btc_krw')
    # pp result
    assert result.success?
    refute_nil result
  end
end
