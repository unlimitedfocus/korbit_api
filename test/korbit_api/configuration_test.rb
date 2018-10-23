require 'test_helper'

class ConfigurationTest < Minitest::Test
  def setup
    @configuration = KorbitApi::Configuration.new
  end

  def test_default_base_url
    assert_equal "#{KorbitApi::DOMAIN}/#{KorbitApi::API_VERSION}", @configuration.base_url
  end
  
  def test_default_domain
    assert_equal 'https://api.korbit.co.kr', ::KorbitApi::DOMAIN
  end

  def test_api_version
    assert_equal 'v1', ::KorbitApi::API_VERSION
  end
end
