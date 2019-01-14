module KorbitApi
  # Defines constants and methods related to configuration
  class Configuration
    # An array of valid keys in the options hash when configuring a {KorbitApi::API}
    VALID_OPTIONS_KEYS = [
      :access_token,
      :client_id,
      :client_secret,
      :username,
      :password,
      :endpoint,
      :user_agent,
      :debug
    ].freeze

    VALID_PRIVATE_API_KEYS = [
      :client_id,
      :client_secret,
      :username,
      :password
    ].freeze

    attr_accessor *VALID_OPTIONS_KEYS

    # By default, don't set a user access token
    DEFAULT_ACCESS_TOKEN = nil

    # By default, don't set an application ID
    DEFAULT_CLIENT_ID = nil

    # By default, don't set an application secret
    DEFAULT_CLIENT_SECRET = nil

    DEFAULT_BASE_URL = 'https://api.korbit.co.kr'.freeze
    DEFAULT_API_VERSION = 'v1'.freeze

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_ENDPOINT = "#{DEFAULT_BASE_URL}/#{DEFAULT_API_VERSION}".freeze

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "Korbit API Ruby Gem #{KorbitApi::VERSION}".freeze

    def initialize(access_token = nil, client_id = nil, client_secret = nil, username = nil, password = nil, user_agent = DEFAULT_USER_AGENT, endpoint = DEFAULT_ENDPOINT, debug = false)
      @access_token   = access_token
      @client_id      = client_id
      @client_secret  = client_secret
      @username       = username
      @password       = password
      @user_agent     = user_agent
      @endpoint       = endpoint
      @debug          = debug
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      @access_token   = DEFAULT_ACCESS_TOKEN
      @client_id      = DEFAULT_CLIENT_ID
      @client_secret  = DEFAULT_CLIENT_SECRET
      @username       = nil
      @password       = nil
      @user_agent     = DEFAULT_USER_AGENT
      @endpoint       = DEFAULT_ENDPOINT
      @debug          = false
    end
  end
end
