require 'httparty'

module KorbitApi
  class PublicApi
    include HTTParty
    base_uri 'https://api.korbit.co.kr/v1'

    attr_accessor :user_agent

    def initialize(endpoint = KorbitApi::Configuration::DEFAULT_ENDPOINT, user_agent = KorbitApi::Configuration::DEFAULT_USER_AGENT, debug = false)
      self.class.base_uri endpoint
      self.class.format :json
      self.class.debug_output STDOUT if debug

      @user_agent = user_agent
    end

    def user_agent_headers
      { 'User-Agent': user_agent }
    end

    # https://apidocs.korbit.co.kr/#ticker
    def ticker(currency_pair = 'btc_krw')
      self.class.get(
        '/ticker', 
        query: {
          currency_pair: currency_pair
        },
        headers: user_agent_headers
      ).parsed_response
    end

    # https://apidocs.korbit.co.kr/#detailed-ticker
    def ticker_detailed(currency_pair = 'btc_krw')
      self.class.get(
        '/ticker/detailed', 
        query: {
          currency_pair: currency_pair
        },
        headers: user_agent_headers
      ).parsed_response
    end

    # https://apidocs.korbit.co.kr/#constants
    def constants(currency_pair = 'btc_krw')
      self.class.get(
        '/constants', 
        query: {
          currency_pair: currency_pair
        },
        headers: user_agent_headers
      ).parsed_response
    end

    # https://apidocs.korbit.co.kr/#orderbook
    def orderbook(currency_pair = 'btc_krw')
      self.class.get(
        '/orderbook', 
        query: {
          currency_pair: currency_pair
        },
        headers: user_agent_headers
      ).parsed_response
    end

    # https://apidocs.korbit.co.kr/#list-of-filled-orders
    # TIME_KEYS = %i(minute hour day)
    def transactions(currency_pair = 'btc_krw', time = 'hour')
      self.class.get(
        '/transactions', 
        query: {
          currency_pair: currency_pair,
          time: time
        },
        headers: user_agent_headers
      ).parsed_response
    end
  end
end
