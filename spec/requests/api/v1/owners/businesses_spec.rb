require 'rails_helper'

RSpec.describe "Api::V1::Owners::Businesses", type: :request do
  describe "GET /index" do
    let(:owner) { create(:user, :owner) }
    let(:business) { create(:business, owner: owner) }
    let(:business_params) { attributes_for(:business) }

    describe 'GET /api/v1/owners/businesses' do

      context 'when business is available' do
        before(:each) do
          business
          get "/api/v1/owners/#{owner.id}/businesses", headers: basic_auth_headers(owner.email, 'password')
        end

        it 'returns http success' do
          expect(response).to have_http_status(:success)
        end

        it 'should show active and available businesses' do
          json = JSON.parse(response.body)
          expect(json["data"].first["attributes"]["id"]).to eq(business.id)
        end
      end

      context 'when business is not available' do
        before(:each) do
          business.update!(shares_available: 0)
          get "/api/v1/owners/#{owner.id}/businesses", headers: basic_auth_headers(owner.email, 'password')
        end

        it 'returns http success' do
          expect(response).to have_http_status(:ok)
        end

        it 'shows all businesses created by owner' do
          json = JSON.parse(response.body)
          expect(json["data"].first["attributes"]["id"]).to eq(business.id)
        end
      end
    end

    describe 'POST /api/v1/owners/businesses' do

      context 'when correct params are passed' do
        before(:each) do
          post "/api/v1/owners/#{owner.id}/businesses", params: { business: business_params }, headers: basic_auth_headers(owner.email, 'password')
        end

        it 'returns http success' do
          expect(response).to have_http_status(:created)
        end

        it 'should create a business' do
          json = JSON.parse(response.body)
          expect(json["data"]["attributes"]["name"]).to eq(business_params[:name])
        end
      end

      context 'when incorrect params are passed' do
        before(:each) do
          post "/api/v1/owners/#{owner.id}/businesses", params: { business: { name: nil } }, headers: basic_auth_headers(owner.email, 'password')
        end

        it 'returns http unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should not create a business' do
          json = JSON.parse(response.body)
          expect(json['name']).to include("can't be blank")
          expect(json['name']).to include("is too short (minimum is 2 characters)")
        end
      end
    end
  end
end
