# app/controllers/api/v1/users_controller.rb
module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_admin!, only: [:destroy]

      def index
        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true)

        render json: @users.as_json(only: [:id, :name, :email, :access_level, :status]), status: :ok
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
