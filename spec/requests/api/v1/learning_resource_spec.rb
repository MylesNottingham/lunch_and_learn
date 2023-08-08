require "rails_helper"

RSpec.describe "Api::V1::LearningResources", type: :request do
  describe "GET /index" do
    context "happy path" do
      it "returns a list of learning resources for a given one word country", :vcr do
        country = "thailand"

        get api_v1_learning_resources_path, params: { country: country }

        expect(response).to have_http_status(:success)

        learning_resources = JSON.parse(response.body, symbolize_names: true)

        expect(learning_resources).to have_key(:data)
        expect(learning_resources[:data]).to be_a(Hash)

        expect(learning_resources[:data]).to have_key(:id)
        expect(learning_resources[:data][:id]).to be_nil

        expect(learning_resources[:data]).to have_key(:type)
        expect(learning_resources[:data][:type]).to eq("learning_resource")

        expect(learning_resources[:data]).to have_key(:attributes)
        expect(learning_resources[:data][:attributes]).to be_a(Hash)

        expect(learning_resources[:data][:attributes]).to have_key(:video)
        expect(learning_resources[:data][:attributes][:video]).to be_a(Hash)

        expect(learning_resources[:data][:attributes][:video]).to have_key(:title)
        expect(learning_resources[:data][:attributes][:video][:title]).to be_a(String)

        expect(learning_resources[:data][:attributes][:video]).to have_key(:youtube_video_id)
        expect(learning_resources[:data][:attributes][:video][:youtube_video_id]).to be_a(String)

        expect(learning_resources[:data][:attributes]).to have_key(:images)
        expect(learning_resources[:data][:attributes][:images]).to be_an(Array)

        learning_resources[:data][:attributes][:images].each do |image|
          expect(image).to be_a(Hash)

          expect(image).to have_key(:alt_tag)
          expect(image[:alt_tag]).to be_a(String)

          expect(image).to have_key(:url)
          expect(image[:url]).to be_a(String)
        end
      end

      it "returns a list of learning resources for a given two word country", :vcr do
        country = "south africa"

        get api_v1_learning_resources_path, params: { country: country }

        expect(response).to have_http_status(:success)

        learning_resources = JSON.parse(response.body, symbolize_names: true)

        expect(learning_resources).to have_key(:data)
        expect(learning_resources[:data]).to be_a(Hash)

        expect(learning_resources[:data]).to have_key(:id)
        expect(learning_resources[:data][:id]).to be_nil

        expect(learning_resources[:data]).to have_key(:type)
        expect(learning_resources[:data][:type]).to eq("learning_resource")

        expect(learning_resources[:data]).to have_key(:attributes)
        expect(learning_resources[:data][:attributes]).to be_a(Hash)

        expect(learning_resources[:data][:attributes]).to have_key(:video)
        expect(learning_resources[:data][:attributes][:video]).to be_a(Hash)

        expect(learning_resources[:data][:attributes][:video]).to have_key(:title)
        expect(learning_resources[:data][:attributes][:video][:title]).to be_a(String)

        expect(learning_resources[:data][:attributes][:video]).to have_key(:youtube_video_id)
        expect(learning_resources[:data][:attributes][:video][:youtube_video_id]).to be_a(String)

        expect(learning_resources[:data][:attributes]).to have_key(:images)
        expect(learning_resources[:data][:attributes][:images]).to be_an(Array)

        learning_resources[:data][:attributes][:images].each do |image|
          expect(image).to be_a(Hash)

          expect(image).to have_key(:alt_tag)
          expect(image[:alt_tag]).to be_a(String)

          expect(image).to have_key(:url)
          expect(image[:url]).to be_a(String)
        end
      end

      it "returns a list of learning resources for a random country if one is not given" do
        get api_v1_learning_resources_path

        expect(response).to have_http_status(:success)

        learning_resources = JSON.parse(response.body, symbolize_names: true)

        expect(learning_resources).to have_key(:data)
        expect(learning_resources[:data]).to be_a(Hash)

        expect(learning_resources[:data]).to have_key(:id)
        expect(learning_resources[:data][:id]).to be_nil

        expect(learning_resources[:data]).to have_key(:type)
        expect(learning_resources[:data][:type]).to eq("learning_resource")

        expect(learning_resources[:data]).to have_key(:attributes)
        expect(learning_resources[:data][:attributes]).to be_a(Hash)

        expect(learning_resources[:data][:attributes]).to have_key(:video)
        expect(learning_resources[:data][:attributes][:video]).to be_a(Hash)

        expect(learning_resources[:data][:attributes][:video]).to have_key(:title)
        expect(learning_resources[:data][:attributes][:video][:title]).to be_a(String)

        expect(learning_resources[:data][:attributes][:video]).to have_key(:youtube_video_id)
        expect(learning_resources[:data][:attributes][:video][:youtube_video_id]).to be_a(String)

        expect(learning_resources[:data][:attributes]).to have_key(:images)
        expect(learning_resources[:data][:attributes][:images]).to be_an(Array)

        learning_resources[:data][:attributes][:images].each do |image|
          expect(image).to be_a(Hash)

          expect(image).to have_key(:alt_tag)
          expect(image[:alt_tag]).to be_a(String)

          expect(image).to have_key(:url)
          expect(image[:url]).to be_a(String)
        end
      end
    end
  end
end
