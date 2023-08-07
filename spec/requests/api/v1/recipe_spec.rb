require 'rails_helper'

RSpec.describe "Api::V1::Recipes", type: :request do
  describe "GET /index" do
    context "happy path" do
      it "returns a list of recipes for a given one word country", :vcr do
        country = "thailand"

        get api_v1_recipes_path, params: { country: country }

        expect(response).to have_http_status(:success)

        recipes = JSON.parse(response.body, symbolize_names: true)

        expect(recipes).to have_key(:data)

        recipes[:data].each do |recipe|
          expect(recipe).to have_key(:id)
          expect(recipe[:id]).to be_nil

          expect(recipe).to have_key(:type)
          expect(recipe[:type]).to eq("recipe")

          expect(recipe).to_not have_key(:shareAs)
          expect(recipe).to_not have_key(:label)
          expect(recipe).to_not have_key(:uri)

          expect(recipe).to have_key(:attributes)

          expect(recipe[:attributes]).to have_key(:title)
          expect(recipe[:attributes][:title]).to be_a(String)

          expect(recipe[:attributes]).to have_key(:url)
          expect(recipe[:attributes][:url]).to be_a(String)

          expect(recipe[:attributes]).to have_key(:country)
          expect(recipe[:attributes][:country]).to be_a(String)

          expect(recipe[:attributes]).to have_key(:image)
          expect(recipe[:attributes][:image]).to be_a(String)

          expect(recipe[:attributes]).to_not have_key(:shareAs)
          expect(recipe[:attributes]).to_not have_key(:label)
          expect(recipe[:attributes]).to_not have_key(:uri)
        end
      end

      it "returns a list of recipes for a given two word country", :vcr do
        country = "south africa"

        get api_v1_recipes_path, params: { country: country }

        expect(response).to have_http_status(:success)

        recipes = JSON.parse(response.body, symbolize_names: true)

        expect(recipes).to have_key(:data)

        recipes[:data].each do |recipe|
          expect(recipe).to have_key(:id)
          expect(recipe[:id]).to be_nil

          expect(recipe).to have_key(:type)
          expect(recipe[:type]).to eq("recipe")

          expect(recipe).to have_key(:attributes)

          expect(recipe[:attributes]).to have_key(:title)
          expect(recipe[:attributes][:title]).to be_a(String)

          expect(recipe[:attributes]).to have_key(:url)
          expect(recipe[:attributes][:url]).to be_a(String)

          expect(recipe[:attributes]).to have_key(:country)
          expect(recipe[:attributes][:country]).to be_a(String)

          expect(recipe[:attributes]).to have_key(:image)
          expect(recipe[:attributes][:image]).to be_a(String)
        end
      end

      it "returns a list of recipes for a random country if one is not given" do
        get api_v1_recipes_path

        expect(response).to have_http_status(:success)

        recipes = JSON.parse(response.body, symbolize_names: true)

        expect(recipes).to have_key(:data)

        recipes[:data].each do |recipe|
          expect(recipe).to have_key(:id)
          expect(recipe[:id]).to be_nil

          expect(recipe).to have_key(:type)
          expect(recipe[:type]).to eq("recipe")

          expect(recipe).to have_key(:attributes)

          expect(recipe[:attributes]).to have_key(:title)
          expect(recipe[:attributes][:title]).to be_a(String)

          expect(recipe[:attributes]).to have_key(:url)
          expect(recipe[:attributes][:url]).to be_a(String)

          expect(recipe[:attributes]).to have_key(:country)
          expect(recipe[:attributes][:country]).to be_a(String)

          expect(recipe[:attributes]).to have_key(:image)
          expect(recipe[:attributes][:image]).to be_a(String)
        end
      end
    end
  end
end
