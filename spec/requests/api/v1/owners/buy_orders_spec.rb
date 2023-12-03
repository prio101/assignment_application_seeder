require 'rails_helper'

RSpec.describe "Api::V1::Owners::BuyOrders", type: :request do
  let(:owner) { create(:user, :owner) }
  let(:business) { create(:business, owner: owner) }
  let(:buyer) { create(:user, :buyer) }
  let(:buy_order) { create(:buy_order, buyer: buyer, business: business) }

  let(:valid_params) do
    { id: buy_order.id, status: 'accepted' }
  end

  describe 'GET /api/v1/owners/buy_orders' do

    context 'when buy_orders are available' do
      before(:each) do
        buy_order
        get "/api/v1/owners/#{owner.id}/buy_orders",
          headers: basic_auth_headers(owner.email, 'password')
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'should show active and available buy_orders' do
        json = JSON.parse(response.body)
        expect(json.first['id']).to eq(buy_order.id)
        expect(json.first['status']).to eq(buy_order.status)
        expect(json.first['business']).to eq(buy_order.business.name)
        expect(json.first['buyer']).to eq(buy_order.buyer.name)
        expect(json.first['quantity']).to eq(buy_order.quantity.to_s)
        expect(json.first['price']).to eq(buy_order.price.to_s)
        expect(json.first['shares_available']).to eq(buy_order.business.shares_available.to_s)
      end
    end

    context 'when buy_orders are not available' do
      before(:each) do
        buy_order.delete
        get "/api/v1/owners/#{owner.id}/buy_orders",
          headers: basic_auth_headers(owner.email, 'password')
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

      it 'shows all buy_orders created by buyer' do
        json = JSON.parse(response.body)
        expect(json["message"]).to eq('No buy orders found')
      end
    end
  end

  describe 'PATCH /api/v1/owners/:owner_id/buy_orders/:id' do
    context 'when correct params are passed' do
      before(:each) do
        patch "/api/v1/owners/#{owner.id}/buy_orders/#{buy_order.id}",
          params: { buy_order: valid_params },
          headers: basic_auth_headers(owner.email, 'password')
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'should update the buy_order' do
        json = JSON.parse(response.body)
        expect(json['status']).to eq(valid_params[:status])
      end
    end

    context 'when incorrect params are passed' do
      before(:each) do
        patch "/api/v1/owners/#{owner.id}/buy_orders/#{buy_order.id}",
          params: { buy_order: { status: nil } },
          headers: basic_auth_headers(owner.email, 'password')
      end

      it 'returns http unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should not update the buy_order' do
        json = JSON.parse(response.body)
        expect(json['status']).to eq(["can't be blank"])
      end
    end
  end

  private

  def basic_auth_headers(email, password)
    {
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
    }
  end
end
