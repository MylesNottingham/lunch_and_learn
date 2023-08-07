require "rails_helper"

RSpec.describe "Api::V1::AirQuality", type: :request do
  describe "GET /index" do
    context "happy path" do
      it "returns the air quality for the capital of a given single word country", :vcr do
        get api_v1_air_quality_index_path, params: { country: "Canada" }

        expect(response).to have_http_status(:success)

        air_quality = JSON.parse(response.body, symbolize_names: true)

        expect(air_quality).to have_key(:data)

        expect(air_quality[:data]).to have_key(:id)
        expect(air_quality[:data][:id]).to be_nil

        expect(air_quality[:data]).to have_key(:type)
        expect(air_quality[:data][:type]).to eq("air_quality")

        expect(air_quality[:data]).to have_key(:attributes)

        expect(air_quality[:data][:attributes]).to have_key(:city)
        expect(air_quality[:data][:attributes][:city]).to eq("Ottawa")

        expect(air_quality[:data][:attributes]).to have_key(:aqi)
        expect(air_quality[:data][:attributes][:aqi]).to be_a(Float)

        expect(air_quality[:data][:attributes]).to have_key(:pm25_concentration)
        expect(air_quality[:data][:attributes][:pm25_concentration]).to be_a(Float)

        expect(air_quality[:data][:attributes]).to have_key(:co_concentration)
        expect(air_quality[:data][:attributes][:co_concentration]).to be_a(Float)
      end

      it "returns the air quality for the capital of a given multiple word country", :vcr do
        get api_v1_air_quality_index_path, params: { country: "United States" }

        expect(response).to have_http_status(:success)

        air_quality = JSON.parse(response.body, symbolize_names: true)

        expect(air_quality).to have_key(:data)

        expect(air_quality[:data]).to have_key(:id)
        expect(air_quality[:data][:id]).to be_nil

        expect(air_quality[:data]).to have_key(:type)
        expect(air_quality[:data][:type]).to eq("air_quality")

        expect(air_quality[:data]).to have_key(:attributes)

        expect(air_quality[:data][:attributes]).to have_key(:city)
        expect(air_quality[:data][:attributes][:city]).to eq("Washington, D.C.")

        expect(air_quality[:data][:attributes]).to have_key(:aqi)
        expect(air_quality[:data][:attributes][:aqi]).to be_a(Float)

        expect(air_quality[:data][:attributes]).to have_key(:pm25_concentration)
        expect(air_quality[:data][:attributes][:pm25_concentration]).to be_a(Float)

        expect(air_quality[:data][:attributes]).to have_key(:co_concentration)
        expect(air_quality[:data][:attributes][:co_concentration]).to be_a(Float)
      end

      it "returns the air quality for a random country if no country is given" do
        get api_v1_air_quality_index_path

        expect(response).to have_http_status(:success)

        air_quality = JSON.parse(response.body, symbolize_names: true)

        expect(air_quality).to have_key(:data)

        expect(air_quality[:data]).to have_key(:id)
        expect(air_quality[:data][:id]).to be_nil

        expect(air_quality[:data]).to have_key(:type)
        expect(air_quality[:data][:type]).to eq("air_quality")

        expect(air_quality[:data]).to have_key(:attributes)

        expect(air_quality[:data][:attributes]).to have_key(:city)
        expect(air_quality[:data][:attributes][:city]).to be_a(String)

        expect(air_quality[:data][:attributes]).to have_key(:aqi)
        expect(air_quality[:data][:attributes][:aqi]).to be_a(Float)

        expect(air_quality[:data][:attributes]).to have_key(:pm25_concentration)
        expect(air_quality[:data][:attributes][:pm25_concentration]).to be_a(Float)

        expect(air_quality[:data][:attributes]).to have_key(:co_concentration)
        expect(air_quality[:data][:attributes][:co_concentration]).to be_a(Float)
      end
    end

    context "sad path" do
      it "returns an error if the country is not found", :vcr do
        get api_v1_air_quality_index_path, params: { country: "Atlantis" }

        expect(response).to have_http_status(:not_found)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:error)
        expect(error[:error]).to eq("Country not found")
      end
    end
  end
end
