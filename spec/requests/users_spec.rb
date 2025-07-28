require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let!(:admin) { create(:user, :admin) }
  let!(:member) { create(:user) }

  describe "GET /api/v1/users" do
    context 'when authenticated' do
      before { get '/api/v1/users', headers: auth_headers(admin) }

      it 'returns a list of users' do
        expect(response).to have_http_status(:ok)
        expect(json_response.size).to eq(2)
      end
    end

    context 'without authentication' do
      it 'returns an unauthorized error' do
        get '/api/v1/users'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "DELETE /api/v1/users/:id" do
    let!(:user_to_inactivate) { create(:user) }

    context 'as an admin' do
      it 'inactivates the user' do
        delete "/api/v1/users/#{user_to_inactivate.id}", headers: auth_headers(admin)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'as a non-admin' do
      it 'returns a forbidden error' do
        delete "/api/v1/users/#{user_to_inactivate.id}", headers: auth_headers(member)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
