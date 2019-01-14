module KorbitApi
  class Authorization
    include HTTParty
    base_uri 'https://api.korbit.co.kr/v1'

    attr_accessor :client_id, :client_secret, :refresh_token, :username, :password, :user_agent, :endpoint, :access_token, :refresh_token

    def initialize(client_id, client_secret, username, password, user_agent = KorbitApi::Configuration::DEFAULT_USER_AGENT, endpoint = KorbitApi::Configuration::DEFAULT_ENDPOINT, debug = false)
      self.class.base_uri endpoint
      self.class.debug_output STDOUT if debug
      self.class.format :json

      @client_id = client_id
      @client_secret = client_secret
      @username = username
      @password = password
      @user_agent = user_agent
      @endpoint = endpoint
    end

    def refresh_expired_token
      return if refresh_token.nil? || username.nil? || password.nil?

      result = Authorization.refresh(client_id, client_secret, refresh_token, user_agent)
      @access_token = result['access_token']
      @refresh_token = result['refresh_token']
      @access_token
    end

    def get_access_token
      return if username.nil? || password.nil?

      result = Authorization.create(client_id, client_secret, username, password)
      @access_token = result['access_token']
      @refresh_token = result['refresh_token']
      @access_token
    end

    def self.create(client_id, client_secret, email, password, user_agent = KorbitApi::Configuration::DEFAULT_USER_AGENT)
      response = self.post(
        '/oauth2/access_token',
        body: {
          client_id: client_id,
          client_secret: client_secret,
          username: email,
          password: password,
          grant_type: 'password'
        },
        headers: {
          'nonce': KorbitApi.nonce,
          'User-Agent': user_agent
        }
      )
      return if [401, 403].include? response.code
      response.parsed_response
    end

    def self.refresh(client_id, client_secret, refresh_token, user_agent = KorbitApi::Configuration::DEFAULT_USER_AGENT, debug = false)
      response = self.post(
        '/oauth2/access_token',
        body: {
          client_id: client_id,
          client_secret: client_secret,
          refresh_token: refresh_token,
          grant_type: 'refresh_token'
        },
        headers: {
          'nonce': KorbitApi.nonce,
          'User-Agent': user_agent
        }
      )

      return if [400, 401].include? response.code
      response.parsed_response
    end
  end
end
