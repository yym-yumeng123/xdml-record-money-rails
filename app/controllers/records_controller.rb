class RecordsController < ApplicationController
  before_action :must_sign_in

  def create
    must_sign_in
    render_resource Record.create create_params
  end

  def destroy
    must_sign_in
    @record = Record.find params[:id]
    head @record.destroy ? :ok : :bad_request
  end

  def index
    render_arr_resource Record.page(params[:page])
  end

  def show
    @record = Record.find params[:id]
    render_resource @record
  end

  def update
    @record = Record.find(params[:id])

    @record.update create_params
    render_resource @record
  end

  private

  def create_params
    params.permit(:amount, :category, :notes)
  end

end
