require 'httparty'

module KorbitApi
  class PublicApi
    include HTTParty

    class << self
      def ticker
        result = self.get("#{KorbitApi.base_url}/ticker").parsed_response
        JSON.parse result
      end
      
      def ticker_detailed
        result = self.get("#{KorbitApi.base_url}/ticker/detailed").parsed_response
        JSON.parse result
      end

      def constants
        self.get("#{KorbitApi.base_url}/constants").parsed_response
      end

      def orderbook
        result = self.get("#{KorbitApi.base_url}/orderbook").parsed_response
        JSON.parse result
      end

      def transactions
        self.get("#{KorbitApi.base_url}/transactions").parsed_response
      end
    end
  end
end
