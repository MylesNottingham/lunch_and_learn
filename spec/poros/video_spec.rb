require "rails_helper"

RSpec.describe Video, type: :poro do
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

    expect(video.title).to eq("Thai Iced Tea")
    expect(video.youtube_video_id).to eq("123")
  end
end
