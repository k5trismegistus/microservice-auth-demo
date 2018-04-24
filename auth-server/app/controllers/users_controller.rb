class UsersController < ApplicationController
  def create
    @user = User.create!(
      username: params['name'],
      password_hash: Digest::MD5.hexdigest(params['password'])
    )

    redirect_to "/users/#{@user.id}"
  rescue
    redirect_to '/error'
  end

  def show
    @user = User.find(params[:id])
  end
end
