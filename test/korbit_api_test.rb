require 'test_helper'

class KorbitApiTest < Minitest::Test
  def test_version_number
    assert_equal '0.0.0', ::KorbitApi::VERSION
  end
  
  # def test_base_url
  #   assert_equal 'https://api.korbit.co.kr', ::KorbitApi::BASE_URL
  # end

  def test_api_version
    assert_equal 'v1', ::KorbitApi::API_VERSION
  end

  def test_client
    refute_nil KorbitApi.client
  end
end
