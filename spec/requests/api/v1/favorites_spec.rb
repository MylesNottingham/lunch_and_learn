require "rails_helper"

RSpec.describe "Api::V1::Favorites", type: :request do
  describe "POST /create" do
    context "happy path" do
      before :each do
        @user1 = User.create!(
          name: "Odell",
          email: "goodboy@ruffruff.com",
          password: "treats4lyf",
          password_confirmation: "treats4lyf"
        )

        @favorite_params = {
          "api_key": @user1.api_key,
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/cook/recipes/crab-fried-rice-recipe-thai-food",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }.to_json
      end

      it "creates a favorite and returns the correct json response" do
        post api_v1_favorites_path, params: @favorite_params

        expect(response).to have_http_status(:created)

        favorite = JSON.parse(response.body, symbolize_names: true)

        expect(favorite).to have_key(:success)
        expect(favorite[:success]).to eq("Favorite added successfully")
      end

      it "creates a favorite in the database" do
        expect(Favorite.count).to eq(0)

        post api_v1_favorites_path, params: @favorite_params

        expect(Favorite.count).to eq(1)

        favorite = Favorite.last

        expect(favorite.user_id).to eq(@user1.id)
        expect(favorite.country).to eq("thailand")
        expect(favorite.recipe_link).to eq("https://www.tastingtable.com/cook/recipes/crab-fried-rice-recipe-thai-food")
        expect(favorite.recipe_title).to eq("Crab Fried Rice (Khaao Pad Bpu)")
      end
    end

    context "sad path" do
      before :each do
        @user1 = User.create!(
          name: "Odell",
          email: "goodboy@ruffruff.com",
          password: "treats4lyf",
          password_confirmation: "treats4lyf"
        )
      end

      it "returns an error if the api key is missing" do
        favorite_params = {
          "api_key": nil,
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/cook/recipes/crab-fried-rice-recipe-thai-food",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }.to_json

        expect(Favorite.count).to eq(0)

        post api_v1_favorites_path, params: favorite_params

        expect(response).to have_http_status(:unauthorized)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Invalid API key")

        expect(Favorite.count).to eq(0)
      end

      it "returns an error if the country is missing" do
        favorite_params = {
          "api_key": @user1.api_key,
          "country": nil,
          "recipe_link": "https://www.tastingtable.com/cook/recipes/crab-fried-rice-recipe-thai-food",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }.to_json

        expect(Favorite.count).to eq(0)

        post api_v1_favorites_path, params: favorite_params

        expect(response).to have_http_status(:unprocessable_entity)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Country can't be blank")

        expect(Favorite.count).to eq(0)
      end

      it "returns an error if the recipe link is missing" do
        favorite_params = {
          "api_key": @user1.api_key,
          "country": "thailand",
          "recipe_link": nil,
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }.to_json

        expect(Favorite.count).to eq(0)

        post api_v1_favorites_path, params: favorite_params

        expect(response).to have_http_status(:unprocessable_entity)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Recipe link can't be blank")

        expect(Favorite.count).to eq(0)
      end

      it "returns an error if the recipe title is missing" do
        favorite_params = {
          "api_key": @user1.api_key,
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/cook/recipes/crab-fried-rice-recipe-thai-food",
          "recipe_title": nil
        }.to_json

        expect(Favorite.count).to eq(0)

        post api_v1_favorites_path, params: favorite_params

        expect(response).to have_http_status(:unprocessable_entity)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Recipe title can't be blank")

        expect(Favorite.count).to eq(0)
      end

      it "returns an error if the api key is invalid" do
        favorite_params = {
          "api_key": "uZcmGvVeMcAs0005UQeuqnEP",
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/cook/recipes/crab-fried-rice-recipe-thai-food",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }.to_json

        expect(Favorite.count).to eq(0)

        post api_v1_favorites_path, params: favorite_params

        expect(response).to have_http_status(:unauthorized)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Invalid API key")

        expect(Favorite.count).to eq(0)
      end
    end
  end
end
