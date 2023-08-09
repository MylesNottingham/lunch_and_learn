class Api::V1::FavoritesController < ApplicationController
  def create
    favorite = Favorite.new(params)

    if favorite.save
      render json: { message: "Favorite added successfully" }, status: :created
    else
      if favorite.errors.full_messages.include?("User must exist")
        render json: { errors: ["Invalid API key"] }, status: :unauthorized
      else
        render json: { errors: favorite.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  def params
    params = JSON.parse(request.body.read, symbolize_names: true)

    params[:user_id] = get_user_id(params[:api_key])
    params.delete(:api_key)

    params
  end

  def get_user_id(api_key)
    User.find_by(api_key: api_key)&.id
  end
end
