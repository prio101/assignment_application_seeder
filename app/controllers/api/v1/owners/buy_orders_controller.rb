class Api::V1::Owners::BuyOrdersController < ApplicationController
  # GET /owners/buy_orders
  def index
    @buy_orders = current_user.businesses.map(&:buy_orders).flatten
    if @buy_orders.empty?
      render json: { message: 'No buy orders found' }, status: :ok
    else
      render json: serialized_response, status: :ok
    end
  end

  # PATCH /owners/buy_orders/:id
  # params: { id: [integer | string], status: string }
  def update
    @buy_order = BuyOrder.find_by(id: params[:id], business_id: current_user.businesses.pluck(:id))
    if @buy_order.update(status: buy_order_params[:status])
      ActiveRecord::Base.transaction do
        @buy_order.update_shares_available
      end
      render json: @buy_order, status: :ok
    else
      render json: @buy_order.errors, status: :unprocessable_entity
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def buy_order_params
    params.require(:buy_order).permit(:id, :status)
  end

  def serialized_response
    @buy_orders.map do |buy_order|
      {
        id: buy_order.id,
        quantity: buy_order.quantity,
        price: buy_order.price,
        status: buy_order.status,
        business: buy_order.business.name,
        buyer: buy_order.buyer.name,
        shares_available: buy_order.business.shares_available
      }
    end
  end
end
