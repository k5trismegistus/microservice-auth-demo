class SessionsController < ApplicationController

  # このルーティングはnginxでVPC内部からしかアクセス出来ないようにする
  def verify
    @session = Session.find_by(session_key: params[:session_key])
    @user = @session.user

    user_json = @user.attributes.slice('id', 'username')

    render json: user_json
  rescue
    render json: { meta: { status: 401 }}, status: 401
  end

  def create
    @user = User.find_by(username: params['name'])

    redirect_to '/error' unless Digest::MD5.hexdigest(params['password']) == @user.password_hash

    session_key = Digest::MD5.hexdigest("salt_#{@user.id}_#{Time.zone.now}")

    @session = Session.create!(
      user_id: @user.id,
      session_key: session_key
    )

    cookies[:session_key] = session_key

    redirect_to "/users/#{@user.id}"
  end

  def destroy
    @session = Session.find_by(session_key: cookies[:session_key])
    cookies.delete('session_key')

    @session.destroy
    redirect_to '/login'
  end
end
