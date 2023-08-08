class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(params)

    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def params
    JSON.parse(request.body.read, symbolize_names: true)
  end
end
