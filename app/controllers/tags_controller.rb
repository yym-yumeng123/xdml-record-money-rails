class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :update, :destroy]
  before_action :must_sign_in

  # POST /tags
  def create
    render_resource Tag.create tag_params
  end

  # DELETE /tags/1
  def destroy
    head @tag.destroy ? :ok : :bad_request
  end

  # GET /tags
  def index
    @tags = Tag.all

    render json: @tags
  end



  # GET /tags/1
  def show
    render json: @tag
  end



  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
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
