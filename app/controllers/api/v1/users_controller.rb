class Api::V1::UsersController < ApplicationController
  def create
    if params[:password] == params[:password_confirmation]
      user = User.create(user_params)
      return invalid_credentials if user.auth_token.nil?
      render json: UserSerializer.user_data(user)
    else
      render status: 404
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation, :auth_token)
  end

  private
  def invalid_credentials
    render json: { data: { message: 'Incorrect Email/Password' } }
  end
end
