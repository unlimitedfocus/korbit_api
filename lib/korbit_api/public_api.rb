require 'httparty'

module KorbitApi
  class PublicApi
    include HTTParty

    def initialize(options = {})
      self.class.base_uri options[:endpoint]
    end

    # https://apidocs.korbit.co.kr/#ticker
    def ticker(currency_pair = 'btc_krw')
      result = self.class.get("/ticker", query: {
        currency_pair: currency_pair
      }).parsed_response
      JSON.parse result
    end

    # https://apidocs.korbit.co.kr/#detailed-ticker
    def ticker_detailed(currency_pair = 'btc_krw')
      result = self.class.get("/ticker/detailed", query: {
        currency_pair: currency_pair
      }).parsed_response
      JSON.parse result
    end

    # https://apidocs.korbit.co.kr/#constants
    def constants(currency_pair = 'btc_krw')
      self.class.get("/constants", query: {
        currency_pair: currency_pair
      }).parsed_response
    end

    # https://apidocs.korbit.co.kr/#orderbook
    def orderbook(currency_pair = 'btc_krw')
      result = self.class.get("/orderbook", query: {
        currency_pair: currency_pair
      }).parsed_response
      JSON.parse result
    end

    # https://apidocs.korbit.co.kr/#list-of-filled-orders
    # TIME_KEYS = %i(minute hour day)
    def transactions(currency_pair = 'btc_krw', time = 'hour')
      result = self.class.get("/transactions", query: {
        currency_pair: currency_pair,
        time: time
      })

      JSON.parse result
    end
  end
end
