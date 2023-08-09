require "rails_helper"

RSpec.describe "Api::V1::Sessions", type: :request do
  describe "POST /create" do
    context "happy path" do
      before :each do
        User.create!(
          name: "Odell",
          email: "goodboy@ruffruff.com",
          password: "treats4lyf",
          password_confirmation: "treats4lyf"
        )

        @user_input = {
          email: "goodboy@ruffruff.com",
          password: "treats4lyf"
        }
      end

      it "can create a session and return the correct json response" do
        expect(User.count).to eq(1)
        expect(User.last.email).to eq("goodboy@ruffruff.com")
        expect(User.last.authenticate("treats4lyf")).to eq(User.last)

        post api_v1_sessions_path, params: @user_input

        expect(response).to have_http_status(:ok)

        user = JSON.parse(response.body, symbolize_names: true)

        expect(user).to have_key(:data)

        expect(user[:data]).to have_key(:id)
        expect(user[:data][:id]).to be_a(String)

        expect(user[:data]).to have_key(:type)
        expect(user[:data][:type]).to eq("user")

        expect(user[:data]).to have_key(:attributes)
        expect(user[:data][:attributes]).to be_a(Hash)

        expect(user[:data][:attributes]).to have_key(:name)
        expect(user[:data][:attributes][:name]).to be_a(String)

        expect(user[:data][:attributes]).to have_key(:email)
        expect(user[:data][:attributes][:email]).to be_a(String)

        expect(user[:data][:attributes]).to have_key(:api_key)
        expect(user[:data][:attributes][:api_key]).to be_a(String)

        expect(user[:data][:attributes]).to_not have_key(:password_digest)
        expect(user[:data][:attributes]).to_not have_key(:password)
        expect(user[:data][:attributes]).to_not have_key(:password_confirmation)

        expect(user[:data][:attributes][:api_key]).to eq(User.last.api_key)
      end
    end

    context "sad path" do
      before :each do
        User.create!(
          name: "Odell",
          email: "goodboy@ruffruff.com",
          password: "treats4lyf",
          password_confirmation: "treats4lyf"
        )
      end

      it "returns an error if the email is missing" do
        user_input = {
          email: nil,
          password: "treats4lyf"
        }

        post api_v1_sessions_path, params: user_input

        expect(response).to have_http_status(:unauthorized)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Invalid credentials")
      end

      it "returns an error if the password is missing" do
        user_input = {
          email: "goodboy@ruffruff.com",
          password: nil
        }

        post api_v1_sessions_path, params: user_input

        expect(response).to have_http_status(:unauthorized)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Invalid credentials")
      end

      it "returns an error if the password is incorrect" do
        user_input = {
          email: "goodboy@ruffruff.com",
          password: "treats4life"
        }

        post api_v1_sessions_path, params: user_input

        expect(response).to have_http_status(:unauthorized)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Invalid credentials")
      end

      it "returns an error if the email is incorrect" do
        user_input = {
          email: "goodboy@ruffruff.org",
          password: "treats4lyf"
        }

        post api_v1_sessions_path, params: user_input

        expect(response).to have_http_status(:unauthorized)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Invalid credentials")
      end
    end
  end
end
