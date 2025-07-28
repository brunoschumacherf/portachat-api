require 'rails_helper'

RSpec.describe "Authentication API", type: :request do
  let!(:user) { create(:user, password: 'password123') }
  let!(:inactive_user) { create(:user, :inactive, password: 'password123') }

  describe 'POST /api/v1/auth/login' do
    context 'with valid credentials' do
      it 'returns a JWT token and user data' do
        post '/api/v1/auth/login', params: { email: user.email, password: 'password123' }

        expect(response).to have_http_status(:ok)
        expect(json_response['token']).to be_present
        expect(json_response['user']['email']).to eq(user.email)
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized error' do
        post '/api/v1/auth/login', params: { email: user.email, password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'for an inactive user' do
      it 'returns an unauthorized error' do
        post '/api/v1/auth/login', params: { email: inactive_user.email, password: 'password123' }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
