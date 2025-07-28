require 'rails_helper'

RSpec.describe "User Webhooks", type: :request do
  describe "POST /api/v1/webhooks/users" do
    let(:valid_attributes) { { user: { name: 'New User', email: 'new@example.com', access_level: 'member' } } }

    it "creates a new User and sends a welcome email" do
      expect {
        post "/api/v1/webhooks/users", params: valid_attributes.to_json, headers: { 'Content-Type' => 'application/json' }
      }.to change(User, :count).by(1)

      expect(ActiveJob::Base.queue_adapter.enqueued_jobs.size).to eq(1)

      expect(response).to have_http_status(:created)
      expect(json_response['id']).to be_an(Integer)
    end
  end
end
