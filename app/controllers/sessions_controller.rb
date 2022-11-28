class SessionsController < ApplicationController
  def create
    # build 不存数据库
    # new 不会触发校验

    @session = Session.new create_params
    @session.validate
    render_resource @session

    session[:current_user_id] = @session.user.id
  end

  def destroy
    session[:current_user_id] = nil
    head :ok
  end

  def create_params
    params.permit(:email, :password)
  end
end
