require 'forwardable'

module KorbitApi
  class PrivateApi
    extend Forwardable
    include HTTParty
    base_uri 'https://api.korbit.co.kr/v1'

    attr_accessor :access_token, :debug, :public_api

    def_delegators :@public_api, :constants, :ticker, :ticker_detailed, :orderbook, :transactions

    def initialize(access_token, endpoint = DEFAULT_ENDPOINT, user_agent = DEFAULT_USER_AGENT, debug = false)
      self.class.base_uri endpoint
      self.class.debug_output STDOUT if debug
      self.class.format :json

      @public_api = PublicApi.new(endpoint)
      @access_token = access_token
      @user_agent = user_agent
      @debug = debug
    end

    def authorization_headers
      { Authorization: "Bearer #{self.access_token}", 'User-Agent': user_agent }
    end

    # https://apidocs.korbit.co.kr/#getting-user-information
    def user_info
      self.class.get('/user/info', headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#check-user's-balances
    def user_balances
      self.class.get('/user/balances', headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#place-a-bid-order
    # TYPE: %i(limit market)
    def orders_buy(currency_pair, type, amount, price = nil)
      case type
      when 'limit'
        self.class.post('/user/orders/buy', query: {
          currency_pair: currency_pair,
          type: type,
          price: price,
          coin_amount: amount,
          nonce: KorbitApi.nonce
        }, headers: authorization_headers)
      when 'market'
        self.class.post('/user/orders/buy', query: {
          currency_pair: currency_pair,
          type: type,
          fiat_amount: amount,
          nonce: KorbitApi.nonce
        }, headers: authorization_headers)
      end
    end

    # https://apidocs.korbit.co.kr/#place-an-ask-order
    def orders_sell(currency_pair, type, coin_amount, price = nil)
      case type
      when 'limit'
        self.class.post('/user/orders/sell', query: {
          currency_pair: currency_pair,
          type: type,
          price: price,
          coin_amount: coin_amount,
          nonce: KorbitApi.nonce
        }, headers: authorization_headers)
      when 'market'
        self.class.post('/user/orders/sell', query: {
          currency_pair: currency_pair,
          type: type,
          coin_amount: coin_amount,
          nonce: KorbitApi.nonce
        }, headers: authorization_headers)
      end
    end

    # https://apidocs.korbit.co.kr/#cancel-open-orders
    def orders_cancel(currency_pair, order_ids)
      self.class.post('/user/orders/cancel', query: {
        currency_pair: currency_pair,
        id: order_ids,
        nonce: KorbitApi.nonce
      }, headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#list-open-orders
    def orders_open(currency_pair = 'btc_krw', offset = 0, limit = 10)
      self.class.get('/user/orders/open', query: {
        currency_pair: currency_pair,
        offset: offset,
        limit: limit,
        nonce: KorbitApi.nonce
      }, headers: authorization_headers)
    end

    # TODO: Not tested
    # https://apidocs.korbit.co.kr/#view-exchange-orders
    def orders(currency_pair = 'btc_krw', status = nil, id = nil, offset = 0, limit = 0)
      self.class.get('/user/orders', query: {
        currency_pair: currency_pair,
        status: status,
        id: id,
        offset: offset,
        limit: limit,
        nonce: KorbitApi.nonce
      }, headers: authorization_headers)
    end

    # TODO: Not tested
    # https://apidocs.korbit.co.kr/#view-transfers
    def user_transfers(currency, type, offset = 0, limit = 0)
      self.class.get('/user/transfers', query: {
        currency: currency,
        type: type,
        offset: offset,
        limit: limit,
        nonce: KorbitApi.nonce
      }, headers: authorization_headers)
    end

    # TODO: Not tested
    # https://apidocs.korbit.co.kr/#transaction-history---order-fills
    def user_transactions(currency_pair, order_ids = nil, offset = 0, limit = 0)
      self.class.get('/user/transactions', query: {
        currency_pair: currency_pair,
        order_id: order_ids,
        offset: offset,
        limit: limit,
        nonce: KorbitApi.nonce
      }, headers: authorization_headers)
    end

    # TODO: Not tested
    # https://apidocs.korbit.co.kr/#trading-volume-and-fees
    def user_volume(currency_pair = 'all')
      self.class.get('/user/volume', query: {
        currency_pair: currency_pair,
        nonce: KorbitApi.nonce
      }, headers: authorization_headers)
    end

    # TODO: Not tested
    # https://apidocs.korbit.co.kr/#check-account-info
    def user_accounts
      self.class.get('/user/accounts', headers: authorization_headers)
    end

    # TODO: Not tested
    # https://apidocs.korbit.co.kr/#assign-btc-address
    def coins_address_assign(currency)
      self.class.post('/user/coins/address/assign', query: {
        currency: currency,
        nonce: KorbitApi.nonce
      }, headers: authorization_headers)
    end

    # TODO: Not tested
    # https://apidocs.korbit.co.kr/#request-btc-withdrawal
    def coins_withdrawal(currency, amount, address, fee_priority = 'normal')
      self.class.post('/user/coins/out', query: {
        currency: currency,
        amount: amount,
        address: address,
        fee_priority: fee_priority,
        nonce: KorbitApi.nonce
      }, headers: authorization_headers)
    end

    # TODO: Not tested
    # https://apidocs.korbit.co.kr/#query-status-of-btc-deposit-and-transfer
    def coins_status(currency, id = nil)
      self.class.get('/user/coins/status', query: {
        currency: currency,
        id: id,
        nonce: KorbitApi.nonce
      }, headers: authorization_headers)
    end

    # TODO: Not tested
    # https://apidocs.korbit.co.kr/#cancel-btc-transfer-request
    def coins_withdrawal_cancel(currency, id)
      self.class.post('/user/coins/out/cancel', query: {
        currency: currency,
        id: id,
        nonce: KorbitApi.nonce
      }, headers: authorization_headers)
    end


    def broker_currencies
      self.class.get(
        '/user/broker/currencies', 
        query: {
          nonce: KorbitApi.nonce
        }, headers: authorization_headers
      ).parsed_response
    end

    def borker_orderbooks(base_currency, counter_currency, depth = 2)
      self.class.get(
        '/user/broker/orderbooks', 
        query: {
          base: base_currency,
          counter: counter_currency, 
          depth: depth,
          nonce: KorbitApi.nonce
        }, headers: authorization_headers
      ).parsed_response
    end

    def broker_orders(base_currency, counter_currency, page = 0. size = 50)
      self.class.get(
        '/user/broker/orderbooks', 
        query: {
          base: base_currency,
          counter: counter_currency, 
          page: page,
          size: size,
          nonce: KorbitApi.nonce
        }, headers: authorization_headers
      ).parsed_response
    end

    def broker_order(order_id)
      self.class.get(
        "/user/broker/orderbooks/#{order_id}", 
        query: {
          nonce: KorbitApi.nonce
        }, headers: authorization_headers
      ).parsed_response
    end

    def broker_trades(base_currency, counter_currency, page = 0, size = 50)
      self.class.get(
        '/user/broker/trades', 
        query: {
          base: base_currency,
          counter: counter_currency, 
          page: page,
          size: size,
          nonce: KorbitApi.nonce
        }, headers: authorization_headers
      ).parsed_response
    end

    def broker_orders_buy(base_currency, counter_currency, price, quantity)
        self.class.post('/user/broker/orders', query: {
          base: base_currency,
          counter: counter_currency, 
          side: 'B',
          price: price,
          quantity: quantity,
          nonce: KorbitApi.nonce
        }, headers: authorization_headers)
    end

    def broker_orders_sell(base_currency, counter_currency, price, quantity)
        self.class.post('/user/broker/orders', query: {
          base: base_currency,
          counter: counter_currency, 
          side: 'S',
          price: price,
          quantity: quantity,
          nonce: KorbitApi.nonce
        }, headers: authorization_headers)
    end
  end
end
