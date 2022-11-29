require 'custom_error'

class ApplicationController < ActionController::API
  # 全局捕获错误
  # 双冒号 命名空间下的类
  # with 使用 render_xxx 方法
  # 2. 全局的地方 render
  rescue_from CustomError::MustSignInError, with: :render_must_sign_in
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

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

  def render_not_found
    render status: :not_found
  end

end
