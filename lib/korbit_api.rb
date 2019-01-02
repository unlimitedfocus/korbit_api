require 'httparty'
require 'korbit_api/configuration'
require 'korbit_api/public_api'
require 'korbit_api/private_api'

module KorbitApi
  extend Configuration

  # Alias for KorbitApi::Client.new
  #
  # @return [KorbitApi::Client]
  def self.client(options = {})
    if options[:access_token] || 
        KorbitApi::Configuration::VALID_PRIVATE_API_KEYS.all? {|key| options.key? key}
      PrivateApi.new(options)
    else
      PublicApi.new(options)
    end
  end
end
