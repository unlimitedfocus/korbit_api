module KorbitApi
  BASE_URL = 'https://api.korbit.co.kr'.freeze
  API_VERSION = 'v1'.freeze

  class << self
    def base_url
      "#{BASE_URL}/#{API_VERSION}"
    end
  end
end
