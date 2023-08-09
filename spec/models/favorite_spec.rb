require "rails_helper"

RSpec.describe Favorite, type: :model do
  describe "relationships" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:country) }
    it { should validate_presence_of(:recipe_title) }
    it { should validate_presence_of(:recipe_link) }

    let(:user) do
      User.create!(
        name: "Odell",
        email: "goodboy@ruffruff.com",
        password: "treats4lyf",
        password_confirmation: "treats4lyf"
      )
    end

    let(:favorite) do
      Favorite.create!(
        user_id: user.id,
        country: "thailand",
        recipe_link: "https://www.tastingtable.com/cook/recipes/crab-fried-rice-recipe-thai-food",
        recipe_title: "Crab Fried Rice (Khaao Pad Bpu)"
      )
    end

    it "validates uniqueness of recipe_link within the scope of user_id" do
      favorite

      should validate_uniqueness_of(:recipe_link).scoped_to(:user_id)
    end
  end
end
