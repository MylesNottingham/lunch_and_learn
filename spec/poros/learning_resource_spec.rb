require "rails_helper"

RSpec.describe LearningResource, type: :poro do
  it "can instantiate with given attributes" do
    country = "thailand"

    video = Video.new(
      {
        items: [
          {
            snippet: {
              title: "Thai Iced Tea"
            },
            id: {
              videoId: "123"
            }
          }
        ]
      }
    )

    image = Image.new(
      {
        alt_description: "Thai Iced Tea",
        urls: {
          regular: "https://www.seriouseats.com"
        }
      }
    )

    learning_resource_data = {
      country: country,
      video: video,
      images: [image]
    }

    learning_resource = LearningResource.new(learning_resource_data)

    expect(learning_resource.id).to eq(nil)
    expect(learning_resource.country).to eq("thailand")
    expect(learning_resource.video.title).to eq("Thai Iced Tea")
    expect(learning_resource.video.youtube_video_id).to eq("123")
    expect(learning_resource.images.first.alt_tag).to eq("Thai Iced Tea")
    expect(learning_resource.images.first.url).to eq("https://www.seriouseats.com")
  end
end
