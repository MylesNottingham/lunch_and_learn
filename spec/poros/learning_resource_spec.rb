# class LearningResource
#   attr_reader :id,
#               :video,
#               :images

#   def initialize(video, images)
#     @id = nil
#     @video = video
#     @images = images
#   end
# end

require "rails_helper"

RSpec.describe LearningResource, type: :poro do
  it "can instantiate with given attributes" do
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

    learning_resource = LearningResource.new(video, [image])

    expect(learning_resource.id).to eq(nil)
    expect(learning_resource.video.title).to eq("Thai Iced Tea")
    expect(learning_resource.video.youtube_video_id).to eq("123")
    expect(learning_resource.images.first.alt_tag).to eq("Thai Iced Tea")
    expect(learning_resource.images.first.url).to eq("https://www.seriouseats.com")
  end
end
