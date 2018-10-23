require 'test_helper'

class KorbitApiTest < Minitest::Test
  def test_version_number
    assert_equal ENV['VERSION'], ::KorbitApi::VERSION
  end
  
  def test_base_url
    assert_equal "#{ENV['BASE_URL']}/v1", KorbitApi.configuration.base_url
  end

  def test_client
    refute_nil KorbitApi.client
  end
end
