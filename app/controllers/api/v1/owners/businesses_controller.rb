class Api::V1::Owners::BusinessesController < ApplicationController
  # will show all businesses created by owner
  # GET /api/v1/owners/:owner_id/businesses
  # Does not require status to be active or available
  def index
    @businesses = current_user.businesses
    render status: :ok
  end

  def create
    @business = current_user.businesses.new(business_params)
    if @business.save
      render status: :created
    else
      render json: @business.errors, status: :unprocessable_entity
    end
  end

  def delete
    @business = current_user.businesses.find(params[:id])
    if @business.present? and @business.active?
      @business.inactive!
      render json: 'Business has been Deactivated.', status: :deleted
    else
      render json: @business.errors, status: :unprocessable_entity
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :shares_available)
  end
end
