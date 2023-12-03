class Api::V1::Buyers::BusinessesController < ApplicationController
  # GET /buyers/businesses
  def index
    @businesses = Business.all
    render json: @businesses, status: :ok
  end

  # GET /buyers/businesses/:id
  # ID: Business ID
  def show
    @business = Business.find(params[:id])
    if @business.present?
      render json: @business, status: :ok
    else
      render json: { error: "Business not found" }, status: :not_found
    end
  end
end
