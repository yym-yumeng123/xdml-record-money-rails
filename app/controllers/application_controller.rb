class ApplicationController < ActionController::API

  # 所有方法都可以 render
  def render_resource resource
    if resource.errors.empty?
      render json: {resouces: resource}, status: 200
    else
      render json: {errors: resource.errors}, status: 400
    end
  end
end
