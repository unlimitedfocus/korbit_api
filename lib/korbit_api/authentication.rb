require 'httparty'

module KorbitApi
  class Authentication
    include HTTParty
    base_uri KorbitApi.configuration.base_url

    # https://apidocs.korbit.co.kr/#direct-authentication
    def self.authenticate(username, password)
      self.class.post('/oauth2/access_token', query: {
        client_id: KorbitApi.configuration.key,
        client_secret: KorbitApi.configuration.secret,
        username: username,
        password: password,
        grant_type: 'password'
      }).parsed_response
    end

    # https://apidocs.korbit.co.kr/#refreshing-access-token
    def self.refresh(refresh_token)
      self.class.post('/oauth2/access_token', query: {
        client_id: KorbitApi.configuration.key,
        client_secret: KorbitApi.configuration.secret,
        refresh_token: refresh_token,
        grant_type: 'refresh_token'
      }).parsed_response
    end
  end
end
