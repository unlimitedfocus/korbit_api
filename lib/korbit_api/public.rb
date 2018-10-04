module KorbitApi
  class Public
    include HTTParty
    base_uri 'https://api.korbit.co.kr'

    # https://apidocs.korbit.co.kr/#constants
    def self.constants
      get('/v1/constants', verify: true)
    end

    # https://apidocs.korbit.co.kr/#ticker
    def self.ticker(currency_pair = 'btc_krw')
      get('/v1/ticker', query: {
        currency_pair: currency_pair
      })
    end

    # https://apidocs.korbit.co.kr/#detailed-ticker
    def self.ticker_detailed(currency_pair = 'btc_krw')
      get('/v1/ticker/detailed', query: {
        currency_pair: currency_pair
      })
    end

    # https://apidocs.korbit.co.kr/#orderbook
    def self.orderbook(currency_pair = 'btc_krw')
      get('/v1/orderbook', query: {
        currency_pair: currency_pair
      })
    end

    # https://apidocs.korbit.co.kr/#list-of-filled-orders
    def self.transactions(currency_pair = 'btc_krw')
      get('/v1/transactions', query: {
        currency_pair: currency_pair
      })
    end
  end
end
