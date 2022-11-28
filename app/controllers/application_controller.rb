class ApplicationController < ActionController::API
  def current_user
    @current_user ||= User.find_by_id session[:current_user_id]
  end

  # 所有方法都可以 render
  def render_resource resource
    return head 404 if  resource.nil?
    if resource.errors.empty?
      render json: {resouces: resource}, status: 200
    else
      render json: {errors: resource.errors}, status: 400
    end
  end
end
