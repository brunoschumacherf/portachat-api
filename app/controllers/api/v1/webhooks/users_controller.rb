module Api
  module V1
    module Webhooks
      class UsersController < ApplicationController
        skip_before_action :authenticate_request, only: [:create]

        def create
          user = User.new(user_params)
          password = user.password = user.password_confirmation = SecureRandom.hex(8)

          if user.save
            UserMailer.welcome_email(user, password).deliver_later
            ActionCable.server.broadcast('users_channel', { type: 'NEW_USER', payload: user.as_json(only: [:id, :name, :email, :access_level, :status]) })
            render json: { id: user.id, status: 'created' }, status: :created
          else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def user_params
          params.require(:user).permit(:name, :email, :access_level)
        end
      end
    end
  end
end
