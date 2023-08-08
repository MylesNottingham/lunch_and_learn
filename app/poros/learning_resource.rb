class LearningResource
  attr_reader :id,
              :video,
              :images

  def initialize(video, images)
    @id = nil
    @video = video
    @images = images
  end
end
