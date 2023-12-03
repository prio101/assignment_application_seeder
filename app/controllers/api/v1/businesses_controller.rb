class Api::V1::BusinessesController < ApplicationController
  before_action :set_business, only: [:show]

  # Will list all the businesses
  # GET /businesses
  def index
    @businesses = Business.all
    render json: { data: @businesses }, status: :ok
  end

  # Will show a business
  # GET /businesses/:id
  def show
    if @business.present?
      render json: { data: @business }, status: :ok
    else
      render json: { error: "Business not found" }, status: :not_found
    end
  end


  private

  def set_business
    @business = Business.find_by(id: params[:id])
  end
end
