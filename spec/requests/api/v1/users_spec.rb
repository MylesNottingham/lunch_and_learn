require "rails_helper"

RSpec.describe "Api::V1::Users", type: :request do
  describe "POST /create" do
    context "happy path" do
      before :each do
        @user_params = {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "password": "treats4lyf",
          "password_confirmation": "treats4lyf"
        }.to_json
      end

      it "creates a user and returns the correct json response" do
        post api_v1_users_path, params: @user_params

        expect(response).to have_http_status(:created)

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
      end

      it "creates a user in the database" do
        expect(User.count).to eq(0)

        post api_v1_users_path, params: @user_params

        expect(User.count).to eq(1)

        user = User.last

        expect(user.name).to eq("Odell")
        expect(user.email).to eq("goodboy@ruffruff.com")
        expect(user.api_key).to be_a(String)

        expect(user.authenticate("treats4lyf")).to eq(user)

        expect(user.password_digest).to_not eq("treats4lyf")
        expect(user.password).to be_nil
        expect(user.password_confirmation).to be_nil
      end
    end

    context "sad path" do
      it "returns an error if the name is missing" do
        user_params = {
          "name": nil,
          "email": "goodboy@ruffruff.com",
          "password": "treats4lyf",
          "password_confirmation": "treats4lyf"
        }.to_json

        expect(User.count).to eq(0)

        post api_v1_users_path, params: user_params

        expect(response).to have_http_status(:unprocessable_entity)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Name can't be blank")

        expect(User.count).to eq(0)
      end

      it "returns an error if the email is missing" do
        user_params = {
          "name": "Odell",
          "email": nil,
          "password": "treats4lyf",
          "password_confirmation": "treats4lyf"
        }.to_json

        expect(User.count).to eq(0)

        post api_v1_users_path, params: user_params

        expect(response).to have_http_status(:unprocessable_entity)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Email can't be blank")

        expect(User.count).to eq(0)
      end

      it "returns an error if the password is missing" do
        user_params = {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "password": nil,
          "password_confirmation": nil
        }.to_json

        expect(User.count).to eq(0)

        post api_v1_users_path, params: user_params

        expect(response).to have_http_status(:unprocessable_entity)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Password can't be blank")

        expect(User.count).to eq(0)
      end

      it "returns an error if the passwords don't match" do
        user_params = {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "password": "treats4lyf",
          "password_confirmation": "treats4life"
        }.to_json

        expect(User.count).to eq(0)

        post api_v1_users_path, params: user_params

        expect(response).to have_http_status(:unprocessable_entity)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Password confirmation doesn't match Password")

        expect(User.count).to eq(0)
      end

      it "returns an error if the email is already taken" do
        user_1_params = {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "password": "treats4lyf",
          "password_confirmation": "treats4lyf"
        }.to_json

        expect(User.count).to eq(0)

        post api_v1_users_path, params: user_1_params

        expect(response).to have_http_status(:created)

        expect(User.count).to eq(1)

        expect(User.last.email).to eq("goodboy@ruffruff.com")

        user_2_params = {
          "name": "Testarossa",
          "email": "goodboy@ruffruff.com",
          "password": "password",
          "password_confirmation": "password"
        }.to_json

        post api_v1_users_path, params: user_2_params

        expect(response).to have_http_status(:unprocessable_entity)

        error = JSON.parse(response.body, symbolize_names: true)

        expect(error).to have_key(:errors)
        expect(error[:errors]).to be_a(Array)
        expect(error[:errors].first).to eq("Email has already been taken")

        expect(User.count).to eq(1)
      end
    end
  end
end
