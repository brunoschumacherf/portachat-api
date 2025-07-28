# app/controllers/api/v1/users_controller.rb
module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_admin!, only: [:destroy]

      def index
        @q = User.ransack(params[:q])

        max_updated_at = @q.result.maximum(:updated_at).try(:to_i)

        query_params_key = params[:q]&.to_unsafe_h&.sort&.to_s || "all"

        cache_key = ['v1', 'users', query_params_key, max_updated_at]

        users_json = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
          @users = @q.result(distinct: true)
          @users.as_json(only: [:id, :name, :email, :access_level, :status])
        end

        render json: users_json, status: :ok
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
