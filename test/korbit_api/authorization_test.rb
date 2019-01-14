require 'test_helper'

class AuthorizationTest < Minitest::Test
  def setup
    @access_token = nil
    @client_id = ENV['CLIENT_ID']
    @client_secret = ENV['CLIENT_SECRET']
    @username = ENV['USERNAME']
    @password = ENV['PASSWORD']
    @user_agent = ENV['USER_AGENT'] || 'testagent'
    @endpoint = ENV['BASE_URL'].nil? ? KorbitApi::Configuration::DEFAULT_ENDPOINT : "#{ENV['BASE_URL']}/v1"
  end

  def test_new
    @authorization_new = KorbitApi::Authorization.new(nil, nil, nil, nil)
    assert_nil @authorization_new.access_token
    assert_nil @authorization_new.client_id
    assert_nil @authorization_new.client_secret
    assert_nil @authorization_new.username
    assert_nil @authorization_new.password
    assert_equal 'https://api.korbit.co.kr/v1', @authorization_new.endpoint
    assert_equal "Korbit API Ruby Gem #{KorbitApi::VERSION}", @authorization_new.user_agent
  end

  def test_authorization
    @authorization = KorbitApi::Authorization.new(@client_id, @client_secret, @username, @password, @user_agent, @endpoint)
    assert_nil @authorization.access_token
    assert_equal @client_id, @authorization.client_id
    assert_equal @client_secret, @authorization.client_secret
    assert_equal @username, @authorization.username
    assert_equal @password, @authorization.password
    assert_equal @user_agent, @authorization.user_agent
    assert_equal @endpoint, @authorization.endpoint
  end

  def test_get_access_token
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
    @authorization = KorbitApi::Authorization.new(@client_id, @client_secret, @username, @password, @user_agent, @endpoint)
    refute_nil @authorization.get_access_token
    refute_nil @authorization.access_token
    refute_nil @authorization.refresh_token
  end

  def test_get_access_token
    return if @endpoint.eql? KorbitApi::Configuration::DEFAULT_ENDPOINT
    @authorization = KorbitApi::Authorization.new(@client_id, @client_secret, @username, @password, @user_agent, @endpoint)
    refute_nil @authorization.get_access_token
    refute_nil @authorization.refresh_expired_token
    refute_nil @authorization.access_token
    refute_nil @authorization.refresh_token
  end
end
