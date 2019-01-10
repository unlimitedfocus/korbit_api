module KorbitApi
  # Defines constants and methods related to configuration
  module Configuration
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

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.client_id      = DEFAULT_CLIENT_ID
      self.client_secret  = DEFAULT_CLIENT_SECRET
      self.access_token   = DEFAULT_ACCESS_TOKEN
      self.endpoint       = DEFAULT_ENDPOINT
      self.user_agent     = DEFAULT_USER_AGENT
      self.username       = nil
      self.password       = nil
    end
  end
end
