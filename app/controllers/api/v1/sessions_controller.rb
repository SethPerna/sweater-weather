class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    return invalid_credentials if user.nil?
    if user.authenticate(params[:password])
      render json: UserSerializer.user_data(user)
    else
      invalid_credentials
    end
  end

  private
  def invalid_credentials
    render json: { data: { message: 'Incorrect Email/Password' } }
  end
end
