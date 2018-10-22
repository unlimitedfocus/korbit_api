require 'korbit_api/configuration'
require 'httparty'

module KorbitApi
  class PublicApi
    include HTTParty
    base_uri KorbitApi.base_uri

    class << self
      def ticker(currency_pair = 'btc_krw')
        result = self.get("/ticker", query: {
          currency_pair: currency_pair
        }).parsed_response
        JSON.parse result
      end
      
      def ticker_detailed(currency_pair = 'btc_krw')
        result = self.get("/ticker/detailed", query: {
          currency_pair: currency_pair
        }).parsed_response
        JSON.parse result
      end

      def constants(currency_pair = 'btc_krw')
        self.get("/constants", query: {
          currency_pair: currency_pair
        }).parsed_response
      end

      def orderbook(currency_pair = 'btc_krw')
        result = self.get("/orderbook", query: {
          currency_pair: currency_pair
        }).parsed_response
        JSON.parse result
      end

      # TIME_KEYS = %i(minute hour day)
      def transactions(currency_pair = 'btc_krw', time = 'hour')
        result = self.get("/transactions", query: {
          currency_pair: currency_pair,
          time: time
        })

        JSON.parse result
      end
    end
  end
end
