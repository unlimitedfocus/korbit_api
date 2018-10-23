require 'korbit_api/configuration'
require 'httparty'

module KorbitApi
  class PublicApi
    include HTTParty
    base_uri KorbitApi.base_uri

    TIME_KEYS = %w(minute hour day).freeze

    class << self
      # https://apidocs.korbit.co.kr/#ticker
      def ticker(currency_pair = 'btc_krw')
        result = self.get("/ticker", query: {
          currency_pair: currency_pair
        }).parsed_response
        JSON.parse result
      end
      
      # https://apidocs.korbit.co.kr/#detailed-ticker
      def ticker_detailed(currency_pair = 'btc_krw')
        result = self.get("/ticker/detailed", query: {
          currency_pair: currency_pair
        }).parsed_response
        JSON.parse result
      end

      # https://apidocs.korbit.co.kr/#constants
      def constants(currency_pair = 'btc_krw')
        self.get("/constants", query: {
          currency_pair: currency_pair
        }).parsed_response
      end

      # https://apidocs.korbit.co.kr/#orderbook
      def orderbook(currency_pair = 'btc_krw')
        result = self.get("/orderbook", query: {
          currency_pair: currency_pair
        }).parsed_response
        JSON.parse result
      end

      # https://apidocs.korbit.co.kr/#list-of-filled-orders
      def transactions(currency_pair = 'btc_krw', time = 'hour')
        raise ArgumentError unless TIME_KEYS.include? time

        result = self.get("/transactions", query: {
          currency_pair: currency_pair,
          time: time
        })

        JSON.parse result
      end
    end
  end
end
