require 'test_helper'

class ConfigurationTest < Minitest::Test
  def setup
    @access_token = nil
    @client_id = ENV['CLIENT_ID']
    @client_secret = ENV['CLIENT_SECRET']
    @username = ENV['USERNAME']
    @password = ENV['PASSWORD']
    @user_agent = ENV['USER_AGENT'] || 'testagent'
    @endpoint = "#{ENV['BASE_URL']}/v1"
    @configuration = KorbitApi::Configuration.new(@access_token, @client_id, @client_secret, @username, @password, @user_agent, @endpoint)
  end

  def test_new
    @configuration_new = KorbitApi::Configuration.new
    assert_nil @configuration_new.access_token
    assert_nil @configuration_new.client_id
    assert_nil @configuration_new.client_secret
    assert_nil @configuration_new.username
    assert_nil @configuration_new.password
    assert_equal 'https://api.korbit.co.kr/v1', @configuration_new.endpoint
    assert_equal "Korbit API Ruby Gem #{KorbitApi::VERSION}", @configuration_new.user_agent
  end

  def test_configuration
    assert_nil @configuration.access_token
    assert_equal @client_id, @configuration.client_id
    assert_equal @client_secret, @configuration.client_secret
    assert_equal @username, @configuration.username
    assert_equal @password, @configuration.password
    assert_equal @user_agent, @configuration.user_agent
  end

  def test_options
    assert_nil @configuration.options[:access_token]
    assert_equal @client_id, @configuration.options[:client_id]
    assert_equal @client_secret, @configuration.options[:client_secret]
    assert_equal @username, @configuration.options[:username]
    assert_equal @password, @configuration.options[:password]
    assert_equal @user_agent, @configuration.options[:user_agent]
  end
end
