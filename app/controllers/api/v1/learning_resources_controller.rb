class Api::V1::LearningResourcesController < ApplicationController
  def index
    video_service = VideoService.new
    image_service = ImageService.new

    if params[:country]
      country = params[:country]
    else
      country = CountryService.new.random_country
    end

    video_data = (video_service.find_video_by_country(country))

    video = Video.new(video_data)

    images_data = (image_service.find_images_by_country(country))

    images = images_data[:results].map do |data|
      Image.new(data)
    end

    learning_resource = LearningResource.new(video, images)

    render json: LearningResourceSerializer.new(learning_resource)
  end
end
