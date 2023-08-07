require "rails_helper"

RSpec.describe Recipe, type: :poro do
  it "can instantiate with given attributes" do
    recipe = Recipe.new(
      {
        label: "Thai Iced Tea",
        url: "https://www.seriouseats.com",
        shareAs: "http://www.edamam.com/recipe/---/thailand",
        image: "https://edamam-product-images.s3.amazonaws.com"
      }
    )

    expect(recipe.title).to eq("Thai Iced Tea")
    expect(recipe.url).to eq("https://www.seriouseats.com")
    expect(recipe.country).to eq("thailand")
    expect(recipe.image).to eq("https://edamam-product-images.s3.amazonaws.com")
  end
end
