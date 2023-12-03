class Api::V1::Buyers::BuyOrdersController < ApplicationController
  # GET /buyers/buy_orders
  def index
    @buy_orders = current_user.buy_orders
    render json: @buy_orders, status: :ok
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  # POST /buyers/buy_orders
  # Params: business_id, quantity, price
  def create
    @buy_order = current_user.buy_orders.build(buy_order_params)
    if @buy_order.save
      render json: @buy_order, status: :created
    else
      render json: @buy_order.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def buy_order_params
    params.require(:buy_order).permit(:business_id, :quantity, :price)
  end
end
