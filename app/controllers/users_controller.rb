class UsersController < ApplicationController
    before_action :require_login
    skip_before_action :require_login, only: [:create]

    # rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_data

    def create
        # byebug
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        elsif user.invalid?
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
    end


    def show
        user = User.find(session[:user_id])
        render json: user, status: :created
    end

    private

    def user_params
      params.permit(:username, :password, :password_confirmation)
    end

    # def render_invalid_data(invalid)
    #     render json: {errors: invalid.record.errors}, status: :unprocessable_entity
    # end

    def require_login
        render json: {error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
     end
end
