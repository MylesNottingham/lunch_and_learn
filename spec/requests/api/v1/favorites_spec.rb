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

      it "returns an error if the recipe link is not unique per user" do
        Favorite.create!(
          user_id: @user1.id,
          country: "thailand",
          recipe_link: "https://www.tastingtable.com/cook/recipes/crab-fried-rice-recipe-thai-food",
          recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
        )

        favorite_params = {
          "api_key": @user1.api_key,
          "country": "thailand",
          "recipe_link": "https://www.tastingtable.com/cook/recipes/crab-fried-rice-recipe-thai-food",
          "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
        }.to_json

        expect(Favorite.count).to eq(1)

        post api_v1_favorites_path, params: favorite_params

        expect(response).to have_http_status(:unprocessable_entity)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Recipe link has already been taken")

        expect(Favorite.count).to eq(1)
      end
    end
  end

  describe "GET /index" do
    context "happy path" do
      before :each do
        @user1 = User.create!(
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "password": "treats4lyf",
          "password_confirmation": "treats4lyf"
        )

        @user2 = User.create!(
          "name": "Testarossa",
          "email": "test@testy.com",
          "password": "test",
          "password_confirmation": "test"
        )

        Favorite.create!(
          user_id: @user1.id,
          country: "thailand",
          recipe_link: "https://www.tastingtable.com/cook/recipes/crab-fried-rice-recipe-thai-food",
          recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
        )

        Favorite.create!(
          user_id: @user1.id,
          country: "new+zealand",
          recipe_link: "http://www.marthastewart.com/355892/linguine-new-zealand-cockles",
          recipe_title: "Linguine with New Zealand Cockles recipes"
        )

        Favorite.create!(
          user_id: @user1.id,
          country: "korea",
          recipe_link: "https://food52.com/recipes/25423-the-nonsensical-hot-peppercorn-peanut-brittle",
          recipe_title: "The Nonsensical Hot Peppercorn Peanut Brittle"
        )
      end

      it "returns all favorites for a user in the correct json format" do
        expect(User.count).to eq(2)
        expect(Favorite.count).to eq(3)

        get api_v1_favorites_path, params: { api_key: @user1.api_key }

        expect(response).to have_http_status(:ok)

        favorites = JSON.parse(response.body, symbolize_names: true)

        expect(favorites).to have_key(:data)
        expect(favorites[:data]).to be_a(Array)
        expect(favorites[:data].count).to eq(3)

        favorites[:data].each do |favorite|
          expect(favorite).to have_key(:id)
          expect(favorite[:id]).to be_a(String)

          expect(favorite).to have_key(:type)
          expect(favorite[:type]).to eq("favorite")

          expect(favorite).to have_key(:attributes)
          expect(favorite[:attributes]).to be_a(Hash)

          expect(favorite[:attributes]).to have_key(:recipe_title)
          expect(favorite[:attributes][:recipe_title]).to be_a(String)

          expect(favorite[:attributes]).to have_key(:recipe_link)
          expect(favorite[:attributes][:recipe_link]).to be_a(String)

          expect(favorite[:attributes]).to have_key(:country)
          expect(favorite[:attributes][:country]).to be_a(String)

          expect(favorite[:attributes]).to have_key(:created_at)
          expect(favorite[:attributes][:created_at]).to be_a(String)
        end
      end

      it "returns an empty array if the user has no favorites" do
        get api_v1_favorites_path, params: { api_key: @user2.api_key }

        expect(response).to have_http_status(:ok)

        favorites = JSON.parse(response.body, symbolize_names: true)

        expect(favorites).to have_key(:data)
        expect(favorites[:data]).to eq([])
      end
    end

    context "sad path" do
      before :each do
        @user1 = User.create!(
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "password": "treats4lyf",
          "password_confirmation": "treats4lyf"
        )

        Favorite.create!(
          user_id: @user1.id,
          country: "thailand",
          recipe_link: "https://www.tastingtable.com/cook/recipes/crab-fried-rice-recipe-thai-food",
          recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
        )

        Favorite.create!(
          user_id: @user1.id,
          country: "new+zealand",
          recipe_link: "http://www.marthastewart.com/355892/linguine-new-zealand-cockles",
          recipe_title: "Linguine with New Zealand Cockles recipes"
        )

        Favorite.create!(
          user_id: @user1.id,
          country: "korea",
          recipe_link: "https://food52.com/recipes/25423-the-nonsensical-hot-peppercorn-peanut-brittle",
          recipe_title: "The Nonsensical Hot Peppercorn Peanut Brittle"
        )
      end

      it "returns an error if the api key is missing" do
        get api_v1_favorites_path, params: { api_key: nil }

        expect(response).to have_http_status(:unauthorized)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Invalid API key")
      end

      it "returns an error if the api key is invalid" do
        get api_v1_favorites_path, params: { api_key: "uZcmGvVeMcAs0005UQeuqnEP" }

        expect(response).to have_http_status(:unauthorized)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Invalid API key")
      end
    end
  end
end
