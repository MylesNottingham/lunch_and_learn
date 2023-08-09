class Api::V1::FavoritesController < ApplicationController
  def create
    favorite = Favorite.new(params)

    if favorite.save
      render json: FavoriteSerializer.new(favorite), status: :created
    else
      render json: { errors: favorite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def params
    JSON.parse(request.body.read, symbolize_names: true)
  end
end
