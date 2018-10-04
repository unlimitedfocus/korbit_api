module KorbitApi
  class Private
    include HTTParty
    base_uri 'https://api.korbit.co.kr'

    attr_accessor :access_token

    def initialize(access_token)
      self.access_token = access_token
    end

    def authorization_headers
      { Authorization: "Bearer #{self.access_token}" }
    end

    # https://apidocs.korbit.co.kr/#getting-user-information
    def user_info
      self.class.get('/v1/user/info', headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#place-a-bid-order
    def orders_buy(currency_pair, type, price, coin_amount)
      self.class.post('/v1/user/orders/buy', query: {
        currency_pair: currency_pair,
        type: type,
        price: price,
        coin_amount: coin_amount,
        # nonce: nonce
      }, headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#place-an-ask-order
    def orders_sell(currency_pair, type, price, coin_amount)
      self.class.post('/v1/user/orders/sell', query: {
        currency_pair: currency_pair,
        type: type,
        price: price,
        coin_amount: coin_amount,
        # nonce: nonce
      }, headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#cancel-open-orders
    def orders_cancel(currency_pair, order_ids)
      # https://www.rubydoc.info/github/jnunemaker/httparty/HTTParty/HashConversions#to_params-class_method
      self.class.post('/v1/user/orders/cancel', query: {
        currency_pair: currency_pair,
        id: order_ids,
        # nonce: nonce
      }, headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#list-open-orders
    def orders_open(currency_pair = 'btc_krw', offset = 0, limit = 0)
      self.class.get('/v1/user/orders/open', query: {
        currency_pair: currency_pair,
        offset: offset,
        limit: limit,
        # nonce: nonce
      }, headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#view-exchange-orders
    def orders(currency_pair = 'btc_krw', status = nil, id = nil, offset = 0, limit = 0)
      self.class.get('/v1/user/orders', query: {
        currency_pair: currency_pair,
        status: status,
        id: id,
        offset: offset,
        limit: limit,
        # nonce: nonce
      }, headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#view-transfers
    def user_transfers(currency, type, offset = 0, limit = 0)
      self.class.get('/v1/user/transfers', query: {
        currency: currency,
        type: type,
        offset: offset,
        limit: limit,
        # nonce: nonce
      }, headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#transaction-history---order-fills
    def user_transactions(currency_pair, order_ids = nil, offset = 0, limit = 0)
      self.class.get('/v1/user/transactions', query: {
        currency_pair: currency_pair,
        order_id: order_ids,
        offset: offset,
        limit: limit,
        # nonce: nonce
      }, headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#trading-volume-and-fees
    def user_volume(currency_pair = 'all')
      self.class.get('/v1/user/volume', query: {
        currency_pair: currency_pair,
        # nonce: nonce
      }, headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#check-user's-balances
    def user_balances
      self.class.get('/v1/user/balances', headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#check-account-info
    def user_accounts
      self.class.get('/v1/user/accounts', headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#assign-btc-address
    def coins_address_assign(currency)
      self.class.post('/v1/user/coins/address/assign', query: {
        currency: currency,
        # nonce: nonce
      }, headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#request-btc-withdrawal
    def coins_withdrawal(currency, amount, address, fee_priority = 'normal')
      self.class.post('/v1/user/coins/out', query: {
        currency: currency,
        amount: amount,
        address: address,
        fee_priority: fee_priority,
        # nonce: nonce
      }, headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#query-status-of-btc-deposit-and-transfer
    def coins_status(currency, id = nil)
      self.class.get('/v1/user/coins/status', query: {
        currency: currency,
        id: id,
        # nonce: nonce
      }, headers: authorization_headers)
    end

    # https://apidocs.korbit.co.kr/#cancel-btc-transfer-request
    def coins_withdrawal_cancel(currency, id)
      self.class.post('/v1/user/coins/out/cancel', query: {
        currency: currency,
        id: id,
        # nonce: nonce
      }, headers: authorization_headers)
    end
  end
end
