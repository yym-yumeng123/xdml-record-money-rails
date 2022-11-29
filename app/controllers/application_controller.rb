require 'custom_error'

class ApplicationController < ActionController::API
  rescue_from CustomError::MustSignInError, with: :render_must_sign_in

  # 必须登录方法, 通用错误
  def must_sign_in
    if current_user.nil?
      raise CustomError::MustSignInError
    end
  end

  def current_user
    @current_user ||= User.find_by_id session[:current_user_id]
  end

  # 所有方法都可以 render
  def render_resource resource
    return head 404 if  resource.nil?
    if resource.errors.empty?
      render json: {resources: resource}, status: 200
    else
      render json: {errors: resource.errors}, status: 422
    end
  end

  def render_must_sign_in
    render status: :unauthorized
  end

end
