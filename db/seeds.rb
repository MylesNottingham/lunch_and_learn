# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
Favorite.destroy_all

user1 = User.create!(
  "name": "Odell",
  "email": "goodboy@ruffruff.com",
  "password": "treats4lyf",
  "password_confirmation": "treats4lyf"
)

user2 = User.create!(
  "name": "Testarossa",
  "email": "test@testy.com",
  "password": "test",
  "password_confirmation": "test"
)

Favorite.create!(
  user_id: user1.id,
  country: "thailand",
  recipe_link: "https://www.tastingtable.com/cook/recipes/crab-fried-rice-recipe-thai-food",
  recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
)

Favorite.create!(
  user_id: user1.id,
  country: "new+zealand",
  recipe_link: "http://www.marthastewart.com/355892/linguine-new-zealand-cockles",
  recipe_title: "Linguine with New Zealand Cockles recipes"
)

Favorite.create!(
  user_id: user1.id,
  country: "korea",
  recipe_link: "https://food52.com/recipes/25423-the-nonsensical-hot-peppercorn-peanut-brittle",
  recipe_title: "The Nonsensical Hot Peppercorn Peanut Brittle"
)
