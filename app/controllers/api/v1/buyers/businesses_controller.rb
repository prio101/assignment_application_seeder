module Api
  module V1
    module Buyers
      class BusinessesController < ApplicationController
        # GET /buyers/businesses
        # only the list of businesses that a buyer can buy from
        # Share Availibility > 0
        def index
          @businesses = Business.active.available
          if @businesses.empty?
            render json: { error: "No businesses found" }, status: :not_found
          else
            render json: BusinessSerializer.new(@businesses).serializable_hash, status: :ok
          end
        end

        # Will show a business with available shares only
        # GET /buyers/businesses/:id
        # ID: Business ID
        def show
          @business = Business.active.available.find_by(id: params[:id])
          if @business.present?
            render json: BusinessSerializer.new(@business).serializable_hash, status: :ok
          else
            render json: { error: "Business not found" }, status: :not_found
          end
        end
      end
    end
  end
end
