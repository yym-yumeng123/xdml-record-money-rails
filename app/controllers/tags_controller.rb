class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :update, :destroy]
  before_action :must_sign_in

  # POST /tags
  def create
    render_resource Tag.create tag_params.merge user: current_user
  end

  # DELETE /tags/1
  def destroy
    head @tag.destroy ? :ok : :bad_request
  end

  # GET /tags
  def index
    render_arr_resource Tag.page(params[:page])
  end

  # GET /tags/1
  def show
    render_resource @tag
  end

  # PATCH/PUT /tags/1
  def update
    @tag.update(tag_params)
    render_resource @tag
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.permit(:name)
    end
end
