require 'net/http'

class ApplicationController < ActionController::Base
  before_action :authenticate

  private

  def authenticate
    req_params = { session_key: cookies['session_key'] }
    uri = URI.parse('http://localhost:3000/iapi/sessions')
    uri.query = URI.encode_www_form(req_params)

    p params

    req = Net::HTTP::Get.new uri
    res = Net::HTTP.start(uri.host, uri.port) {|http| http.request req }

    user_response = JSON.parse(res.body)
    username = user_response['username']

    return nil unless username

    @user = User.new(username: username)
  end
end
