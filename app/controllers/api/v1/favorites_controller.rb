class Api::V1::FavoritesController < ApplicationController
  def create
    favorite = Favorite.new(parsed_params)

    if favorite.save
      render json: { success: "Favorite added successfully" }, status: :created
    elsif favorite.errors.full_messages.include?("User must exist")
      render json: { errors: ["Invalid API key"] }, status: :unauthorized
    else
      render json: { errors: favorite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    user_id = get_user_id(params[:api_key])

    if user_id
      favorites = Favorite.where(user_id: user_id)

      render json: FavoriteSerializer.new(favorites)
    else
      render json: { errors: ["Invalid API key"] }, status: :unauthorized
    end
  end

  private

  def parsed_params
    parsed_params = JSON.parse(request.body.read, symbolize_names: true)

    parsed_params[:user_id] = get_user_id(parsed_params[:api_key])
    parsed_params.delete(:api_key)

    parsed_params
  end

  def get_user_id(api_key)
    User.find_by(api_key: api_key)&.id
  end
end
