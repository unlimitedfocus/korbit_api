module KorbitApi
  # BASE_URL = 'https://api.korbit.co.kr'.freeze
  BASE_URL = 'https://api-qa2.korbit-test.com'.freeze
  API_VERSION = 'v1'.freeze

  class << self
    def base_uri
      "#{BASE_URL}/#{API_VERSION}"
    end
  end
end
