require 'rails_helper'

RSpec.describe "User Webhooks API", type: :request do
  include ActiveJob::TestHelper

  describe "POST /api/v1/webhooks/users" do
    let(:headers) { { 'Content-Type' => 'application/json' } }

    context "com parâmetros válidos" do
      let(:valid_attributes) { { user: { name: 'Bruno Silva', email: 'bruno.silva@example.com', access_level: 'member' } } }

      it "cria um novo usuário com sucesso" do
        expect {
          post "/api/v1/webhooks/users", params: valid_attributes.to_json, headers: headers
        }.to change(User, :count).by(1)
      end

      it "retorna o status 201 Created" do
        post "/api/v1/webhooks/users", params: valid_attributes.to_json, headers: headers
        expect(response).to have_http_status(:created)
      end

      it "retorna o ID do novo usuário no corpo da resposta" do
        post "/api/v1/webhooks/users", params: valid_attributes.to_json, headers: headers
        expect(json_response['id']).to eq(User.last.id)
      end

      it "enfileira um e-mail de boas-vindas" do
        clear_enqueued_jobs

        expect {
          post "/api/v1/webhooks/users", params: valid_attributes.to_json, headers: headers
        }.to have_enqueued_job(ActionMailer::MailDeliveryJob)
      end
    end

    context "com parâmetros inválidos" do
      let(:invalid_attributes) { { user: { name: 'Bruno Silva', email: '', access_level: 'member' } } } # Email em branco

      it "não cria um novo usuário" do
        expect {
          post "/api/v1/webhooks/users", params: invalid_attributes.to_json, headers: headers
        }.to_not change(User, :count)
      end

      it "retorna o status 422 Unprocessable Entity" do
        post "/api/v1/webhooks/users", params: invalid_attributes.to_json, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "retorna uma mensagem de erro específica" do
        post "/api/v1/webhooks/users", params: invalid_attributes.to_json, headers: headers
        expect(json_response['errors']).to include("Email can't be blank")
      end
    end

    context "com um email duplicado" do
      let!(:existing_user) { create(:user, email: 'bruno.silva@example.com') }
      let(:duplicate_attributes) { { user: { name: 'Outro Bruno', email: 'bruno.silva@example.com' } } }

      it "não cria um novo usuário" do
        expect {
          post "/api/v1/webhooks/users", params: duplicate_attributes.to_json, headers: headers
        }.to_not change(User, :count)
      end

      it "retorna o status 422 Unprocessable Entity" do
        post "/api/v1/webhooks/users", params: duplicate_attributes.to_json, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "retorna a mensagem de erro de unicidade" do
        post "/api/v1/webhooks/users", params: duplicate_attributes.to_json, headers: headers
        expect(json_response['errors']).to include("Email has already been taken")
      end
    end
  end
end
