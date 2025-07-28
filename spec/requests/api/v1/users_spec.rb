require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let(:admin) { create(:user, :admin) }
  let(:member) { create(:user) }
  let(:user_to_inactivate) { create(:user) }

  describe "DELETE /api/v1/users/:id" do
    context "when user is an admin" do
      it 'returns an unauthorized error' do # Atualize a descrição
        delete "/api/v1/users/#{user_to_inactivate.id}", headers: auth_headers(admin)
        expect(response).to have_http_status(:no_content)
        expect(user_to_inactivate.reload.status).to eq('inactive')
      end
    end

    context "when user is not an admin" do
      it "returns an unauthorized status" do
        delete "/api/v1/users/#{user_to_inactivate.id}", headers: auth_headers(member)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
