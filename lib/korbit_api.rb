require 'korbit_api/configuration'
require 'korbit_api/public_api'
require 'korbit_api/version'

module KorbitApi
  class << self
    def client
      PublicApi
    end
  end
end
