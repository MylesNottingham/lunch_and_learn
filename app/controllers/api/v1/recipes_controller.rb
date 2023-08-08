class Api::V1::RecipesController < ApplicationController
  def index
    recipe_service = RecipeService.new

    country = if params[:country]
                params[:country].downcase
              else
                CountryService.new.random_country
              end

    recipes = recipe_service.find_recipe_by_country(country)

    recipes = recipes[:hits].map do |recipe|
      Recipe.new(recipe[:recipe])
    end

    render json: RecipeSerializer.new(recipes)
  end
end
