require 'korbit_api/configuration'
require 'httparty'

module KorbitApi
  class PublicApi
    include HTTParty
    base_uri KorbitApi.base_uri

    class << self
      def ticker
        result = self.get("/ticker").parsed_response
        JSON.parse result
      end
      
      def ticker_detailed
        result = self.get("/ticker/detailed").parsed_response
        JSON.parse result
      end

      def constants
        self.get("/constants").parsed_response
      end

      def orderbook
        result = self.get("/orderbook").parsed_response
        JSON.parse result
      end

      def transactions
        self.get("/transactions").parsed_response
      end
    end
  end
end
