require 'rails_helper'

RSpec.describe "Businesses", type: :request do
  let(:business) { create(:business) }

  describe "GET /index" do
    before(:each) do
      get "/api/v1/businesses", headers: basic_auth_headers(business.owner.email, 'password')
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'should show all businesses' do
      json = JSON.parse(response.body)
      expect(json['data'].first['id']).to eq(business.id)
    end
  end

  describe 'GET /show' do
    context 'when business is not found' do
      before(:each) do
        get "/api/v1/businesses/0", headers: basic_auth_headers(business.owner.email, 'password')
      end
      it 'returns http not found' do
        Business.destroy_all
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when business is found' do
      before(:each) do
        get "/api/v1/businesses/#{business.id}", headers: basic_auth_headers(business.owner.email, 'password')
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'should show business' do
        json = JSON.parse(response.body)
        expect(json['data']['id']).to eq(business.id)
      end
    end


  end

  private

  def basic_auth_headers(username, password)
    {
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(username, password)
    }
  end
end
