require "rails_helper"

RSpec.describe Image, type: :poro do
  it "can instantiate with given attributes" do
    image = Image.new(
      {
        alt_description: "Thai Iced Tea",
        urls: {
          regular: "https://www.seriouseats.com"
        }
      }
    )

    expect(image.alt_tag).to eq("Thai Iced Tea")
    expect(image.url).to eq("https://www.seriouseats.com")
  end
end
