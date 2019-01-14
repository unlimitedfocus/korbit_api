require 'korbit_api/version'
require 'korbit_api/configuration'
require 'httparty'
require 'korbit_api/authorization'
require 'korbit_api/public_api'
require 'korbit_api/private_api'

module KorbitApi
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.authorization(options = self.configuration.options)
    @authorization ||= Authorization.new(
      options[:client_id], 
      options[:client_secret], 
      options[:username], 
      options[:password], 
      options[:user_agent] || KorbitApi::Configuration::DEFAULT_USER_AGENT,
      options[:endpoint] || KorbitApi::Configuration::DEFAULT_ENDPOINT,
      options[:debug]
    )
  end

  def self.refresh_token
    authorization.refresh_token
  end

  def self.access_token
    authorization.get_access_token
  end

  def self.configure
    yield(configuration)
  end

  # Alias for KorbitApi::Client.new
  #
  # @return [KorbitApi::Client]
  def self.client(options = self.configuration.options)
    @client ||= if KorbitApi::Configuration::VALID_PRIVATE_API_KEYS.all? {|key| options.key? key}
                  PrivateApi.new(access_token, options[:endpoint], options[:user_agent], options[:debug])
                else
                  PublicApi.new
                end
  end

  def self.nonce
    (Time.now.to_f * 1000 + (0 / 1000)).to_i.to_s
  end
end
