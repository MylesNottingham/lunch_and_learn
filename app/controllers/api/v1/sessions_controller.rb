class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      render json: UserSerializer.new(user), status: :ok
    else
      render json: { errors: ["Invalid credentials"] }, status: :unauthorized
    end
  end
end
