class Api::V1::Owners::BuyOrdersController < ApplicationController
  # GET /owners/buy_orders
  def index
    @buy_orders = current_user.businesses.map(&:buy_orders).flatten
    render json: @buy_orders, status: :ok
  end

  # PATCH /owners/buy_orders/:id
  # Params: status
  def update
    @buy_order = BuyOrder.find(params[:id])
    if @buy_order.update(status: params[:status])
      render json: @buy_order, status: :updated
    else
      render json: @buy_order.errors, status: :unprocessable_entity
    end
  end
end
