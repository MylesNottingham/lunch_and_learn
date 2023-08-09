# Lunch and Learn Project

This project is an API-based application aimed at providing various functionalities related to recipes, learning resources, user registration, and favorites. The API endpoints are designed to fulfill specific requirements and provide relevant responses. The project incorporates external APIs such as the REST Countries API, Edamam Recipe API, YouTube API, and the Unsplash API.

## Learning Goals

The primary learning goals of this project include:

- Building an API application using Rails in `--api` mode
- Implementing API endpoints to fulfill specific requirements
- Integrating with external APIs to gather data
- Handling authentication and user registration using bcrypt
- Serializing API responses for specific endpoints
- Conducting testing with RSpec to ensure functionality and proper responses

## Getting Started

To clone and set up the application, follow these steps:

1. Clone the repository from GitHub.

2. Install the required gems by running `bundle install` in the project directory.

3. Set up the necessary database by running `rails db:{create,migrate,seed}`.

4. Obtain the API keys required for external API integration, create a `application.yml' file in the `config` directory, and add the following keys in the following format:
    - `EDAMAM_APP_ID: your_id_here`
    - `EDAMAM_APP_KEY: your_key_here`
    - `YOUTUBE_API_KEY: your_key_here`
    - `UNSPLASH_API_KEY: your_key_here`

      Be sure to add `config/application.yml` to your `.gitignore` file.

5. Start the Rails server by running `rails server`.

6. You can now access the API endpoints using the base URL `http://localhost:3000`.


## API Endpoints

### 1. Get Recipes For A Particular Country

Endpoint: `/api/v1/recipes`

**Request**:

    GET /api/v1/recipes?country=thailand
    Content-Type: application/json
    Accept: application/json

(You can also omit the `country` parameter to get recipes for a random country)

**Response**:

    {
      "data": [
        {
          "id": null,
          "type": "recipe",
          "attributes": {
            "title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)",
            "url": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
            "country": "thailand",
            "image": "https://edamam-product-images.s3.amazonaws.com..."
          }
        },
        {
          "id": null,
          "type": "recipe",
          "attributes": {
            "title": "Sriracha",
            "url": "http://www.jamieoliver.com/recipes/vegetables-recipes/sriracha/",
            "country": "thailand",
            "image": "https://edamam-product-images.s3.amazonaws.com/."
          }
        },
        {...}
      ]
    }

### 2. Get Learning Resources for a Particular Country

Endpoint: `/api/v1/learning_resources`

**Request**:

    GET /api/v1/learning_resources?country=laos
    Content-Type: application/json
    Accept: application/json

(You can also omit the `country` parameter to get recipes for a random country)

**Response**:

    {
      "data": {
        "id": null,
        "type": "learning_resource",
        "attributes": {
          "country": "laos",
          "video": {
            "title": "A Super Quick History of Laos",
            "youtube_video_id": "uw8hjVqxMXw"
          },
          "images": [
            {
              "alt_tag": "standing statue and temples landmark during daytime",
              "url": "https://images.unsplash.com/photo-1528181304800-259b08848526?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
            },
            {
              "alt_tag": "five brown wooden boats",
              "url": "https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwyfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
            },
            {...}
          ]
        }
      }
    }

### 3. User Registration

Endpoint: `/api/v1/users`

**Request**:

    POST /api/v1/users
    Content-Type: application/json
    Accept: application/json

    {
      "name": "Odell",
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf",
      "password_confirmation": "treats4lyf"
    }

**Response**:

    {
      "data": {
        "type": "user",
        "id": "1",
        "attributes": {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "api_key": "jgn983hy48thw9begh98h4539h4"
        }
      }
    }

### 4. Log In User

Endpoint: `/api/v1/sessions`

**Request**:

    POST /api/v1/sessions
    Content-Type: application/json
    Accept: application/json

    {
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf"
    }

**Response**:

    {
      "data": {
        "type": "user",
        "id": "1",
        "attributes": {
          "name": "Odell",
          "email": "goodboy@ruffruff.com",
          "api_key": "jgn983hy48thw9begh98h4539h4"
        }
      }
    }

### 5. Add Favorites

Endpoint: `/api/v1/favorites`

**Request**:

    POST /api/v1/favorites
    Content-Type: application/json
    Accept: application/json

    {
      "api_key": "jgn983hy48thw9begh98h4539h4",
      "country": "thailand",
      "recipe_link": "https://www.tastingtable.com/.....",
      "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
    }

**Response**:

    {
      "success": "Favorite added successfully"
    }

### 6. Get a User's Favorites

Endpoint: `/api/v1/favorites`

**Request**:

    GET /api/v1/favorites?api_key=jgn983hy48thw9begh98h4539h4
    Content-Type: application/json
    Accept: application/json

**Response**:

    {
      "data": [
        {
          "id": "1",
          "type": "favorite",
          "attributes": {
            "recipe_title": "Recipe: Egyptian Tomato Soup",
            "recipe_link": "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....",
            "country": "egypt",
            "created_at": "2022-11-02T02:17:54.111Z"
          }
        },
        {
          "id": "2",
          "type": "favorite",
          "attributes": {
            "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)",
            "recipe_link": "https://www.tastingtable.com/.....",
            "country": "thailand",
            "created_at": "2022-11-07T03:44:08.917Z"
          }
        }
      ]
    }

## Testing

The project includes utilizes RSpec to ensure the functionality and responses of the API endpoints. Testing is not limited to just checking the presence of attribute fields but also verifies the absence of unnecessary data in the responses. To run the tests, simply run `bundle exec rspec` in the project directory.

## Conclusion

This Lunch and Learn project aims to provide a comprehensive API application with various functionalities related to recipes, learning resources, user registration, and favorites. It demonstrates the use of external APIs, proper request and response handling, and authentication.

Feel free to explore the codebase!