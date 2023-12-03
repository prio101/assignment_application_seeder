class Api::V1::Owners::BuyOrdersController < ApplicationController
  # GET /owners/buy_orders
  def index
    @buy_orders = current_user.businesses.map(&:buy_orders).flatten
    if @buy_orders.empty?
      render json: { message: 'No buy orders found' }, status: :ok
    else
      render json: BuyOrderSerializer.new(@buy_orders).serializable_hash, status: :ok
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
      render json: BuyOrderSerializer.new(@buy_order).serializable_hash, status: :ok
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
end
