require 'korbit_api/configuration'
require 'httparty'

module KorbitApi
  class Authentication
    include HTTParty
    base_uri KorbitApi.base_uri

    attr_accessor :key, :secret

    # https://apidocs.korbit.co.kr/#getting-api-keys
    def initialize(key, secret)
      self.key = key
      self.secret = secret
    end

    # https://apidocs.korbit.co.kr/#direct-authentication
    def access_token(username, password)
      self.class.post('/oauth2/access_token', query: {
        client_id: self.key,
        client_secret: self.secret,
        username: username,
        password: password,
        grant_type: 'password'
      })
    end

    # https://apidocs.korbit.co.kr/#refreshing-access-token
    def refresh_token(refresh_token)
      self.class.post('/oauth2/access_token', query: {
        client_id: self.key,
        client_secret: self.secret,
        refresh_token: refresh_token,
        grant_type: 'refresh_token'
      })
    end
  end
end
