# spec/requests/rooms_and_messages_spec.rb
require 'rails_helper'

RSpec.describe "Rooms and Messages API", type: :request do
  let!(:user) { create(:user) }

  describe 'GET /api/v1/rooms' do
    it 'returns ALL rooms' do
      create_list(:room, 2)

      get '/api/v1/rooms', headers: auth_headers(user)

      expect(response).to have_http_status(:ok)
      expect(json_response.size).to eq(2)
    end
  end

  describe 'POST /api/v1/rooms' do
    it 'creates a new room without creating a membership' do

      post '/api/v1/rooms', params: { room: { name: 'Nova Sala Pública' } }.to_json,
                            headers: auth_headers(user).merge({ 'Content-Type' => 'application/json' })

      expect(Room.count).to eq(1)
      expect(RoomMembership.count).to eq(0)
    end
  end

  describe 'Message endpoints' do
    let!(:room) { create(:room) }

    describe 'GET /api/v1/rooms/:room_id/messages' do
      context 'when accessing any room' do
        let!(:message) { create(:message, room: room, user: user) }

        it 'returns the messages for the room' do
          get "/api/v1/rooms/#{room.id}/messages", headers: auth_headers(user)
          expect(response).to have_http_status(:ok)
          expect(json_response.first['content']).to eq(message.content)
        end
      end
    end

    describe 'POST /api/v1/rooms/:room_id/messages' do
      let(:message_params) { { message: { content: 'Olá, mundo!' } } }

      context 'when posting to any room' do
        it 'creates a new message' do
          post "/api/v1/rooms/#{room.id}/messages", params: message_params.to_json, headers: auth_headers(user).merge({ 'Content-Type' => 'application/json' })
          expect(response).to have_http_status(:created)
          expect(Message.last.user).to eq(user)
        end
      end
    end
  end
end
