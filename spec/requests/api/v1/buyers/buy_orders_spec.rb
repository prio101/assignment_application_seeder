require 'rails_helper'

RSpec.describe "Api::V1::Buyers::BuyOrders", type: :request do
  describe "GET /index" do
    let(:buyer) { create(:user, :buyer) }
    let(:business) { create(:business) }
    let(:buy_order) { create(:buy_order,
                              buyer: buyer,
                              business: business) }

    let(:valid_params) do
      { business_id: business.id,quantity: 1, price: 1 }
    end

    let(:invalid_params) do
      { business_id: nil, quantity: nil, price: nil }
    end

    describe 'GET /api/v1/buyers/:buyer_id/buy_orders' do
      context 'when buy_orders are available' do
        before(:each) do
          buy_order
          get "/api/v1/buyers/#{buyer.id}/buy_orders",
            headers: basic_auth_headers(buyer.email, 'password')
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        it 'should show active and available buy_orders' do
          json = JSON.parse(response.body)
          expect(json["data"].first["attributes"]["id"]).to eq(buy_order.id)
        end
      end

      context 'when buy_orders are not available' do
        before(:each) do
          buy_order.delete
          get "/api/v1/buyers/#{buyer.id}/buy_orders",
            headers: basic_auth_headers(buyer.email, 'password')
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

    describe 'POST /api/v1/buyers/:buyer_id/buy_orders' do
      context 'when correct params are passed' do
        before(:each) do
          post "/api/v1/buyers/#{buyer.id}/buy_orders", params: { buy_order: valid_params },
            headers: basic_auth_headers(buyer.email, 'password')
        end

        it 'returns http success' do
          expect(response).to have_http_status(:created)
        end

        it 'should create a buy_order' do
          json = JSON.parse(response.body)
          expect(json["data"]["attributes"]["business"]).to eq(business.name)
        end

      end

      context 'when incorrect params are passed' do
        before(:each) do
          post "/api/v1/buyers/#{buyer.id}/buy_orders", params: { buy_order: invalid_params },
            headers: basic_auth_headers(buyer.email, 'password')
        end

        it 'returns http success' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should create a buy_order' do
          json = JSON.parse(response.body)
          expect(json.first).to eq("Business must exist")
        end
      end
    end
  end
end
