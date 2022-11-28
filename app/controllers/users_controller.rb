class UsersController < ApplicationController
  def create
    @user = User.new
    @user.email = params[:email]
    @user.password = params[:password]
    p @user
    @user.save
  end
end
