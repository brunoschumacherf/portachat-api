# app/controllers/api/v1/users_controller.rb
module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_admin!, only: [:destroy]

      def index
        @users = User.order(name: :asc)
        render json: @users, status: :ok
      end

      def destroy
        user = User.find(params[:id])
        user.inactive!
        head :no_content
      end

      private

      def authorize_admin!
        render json: { error: 'Not Authorized' }, status: :unauthorized unless current_user.admin?
      end
    end
  end
end
