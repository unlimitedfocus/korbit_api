require 'korbit_api/configuration'
require 'korbit_api/public_api'
require 'korbit_api/version'
# require 'korbit_api/authentication'
# require 'korbit_api/private_api'

module KorbitApi
  class << self
    attr_accessor :configuration

    def client
      PublicApi
    end

    # def auth_client(username, password)
    #   tokens = Authentication.authentication(username, password)
    #   if tokens.fetch('access_token', false)
    #     PrivateApi(tokens['access_token'])
    #   else
    #     PublicApi
    #   end
    # end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
