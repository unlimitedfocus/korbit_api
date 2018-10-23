module KorbitApi
  DOMAIN = 'https://api.korbit.co.kr'.freeze
  API_VERSION = 'v1'.freeze

  class Configuration
    attr_accessor :key, :secret, :base_url

    def initialize
      @key = nil
      @secret = nil
      @base_url = "#{DOMAIN}/#{API_VERSION}"
    end

    def enabled?
      !@key.blank? && !@secret.blank?
    end
  end
end
