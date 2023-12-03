require 'rails_helper'

RSpec.describe "/api/v1/buyers/businesses", type: :request do
  describe "GET /api/v1/buyers/businesses" do
    let(:buyer) { create(:user, :buyer) }
    let(:business) { create(:business, shares_available: 100, status: :active) }
    let(:buy_order) { create(:buy_order, buyer: buyer, business: business) }

    describe "/api/v1/buyers/businesses" do

      context 'when business is available' do
        before(:each) do
          business
          get "/api/v1/buyers/#{buyer.id}/businesses", headers: basic_auth_headers(buyer.email, 'password')
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        it 'should show active and available businesses' do
          json = JSON.parse(response.body)
          expect(json.first['id']).to eq(business.id)
        end
      end

      context 'when business is not available' do
        before(:each) do
          business.update!(shares_available: 0)
          get "/api/v1/buyers/#{buyer.id}/businesses", headers: basic_auth_headers(buyer.email, 'password')
        end

        it 'returns http success' do
          expect(response).to have_http_status(:not_found)
        end

        it 'should show active and available businesses' do
          json = JSON.parse(response.body)
          expect(json).to eq({"error"=>"No businesses found"})
        end
      end

      context 'when business is not active' do
        before(:each) do
          business.update!(status: :inactive, shares_available: 0)
          get "/api/v1/buyers/#{buyer.id}/businesses", headers: basic_auth_headers(buyer.email, 'password')
        end

        it 'returns http not found' do
          expect(response).to have_http_status(:not_found)
        end

        it 'should show active and available businesses' do
          json = JSON.parse(response.body)
          expect(json).to eq({"error"=>"No businesses found"})
        end
      end
    end

    describe '/api/v1/buyers/businesses/:id' do
      context 'when business is available' do
        before(:each) do
          business
          get "/api/v1/buyers/#{buyer.id}/businesses/#{business.id}", headers: basic_auth_headers(buyer.email, 'password')
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        it 'should show active and available businesses' do
          json = JSON.parse(response.body)
          expect(json['id']).to eq(business.id)
        end
      end

      context 'when business is not available' do
        before(:each) do
          business.update!(shares_available: 0, status: :inactive)
          get "/api/v1/buyers/#{buyer.id}/businesses/#{business.id}", headers: basic_auth_headers(buyer.email, 'password')
        end

        it 'returns http success' do
          expect(response).to have_http_status(:not_found)
        end

        it 'should show active and available businesses' do
          json = JSON.parse(response.body)
          expect(json).to eq({"error"=>"Business not found"})
        end
      end
    end
  end
end
