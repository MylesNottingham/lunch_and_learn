class Api::V1::LearningResourcesController < ApplicationController
  def index
    video_service = VideoService.new
    image_service = ImageService.new

    country = if params[:country]
                params[:country].downcase
              else
                CountryService.new.random_country
              end

    video_data = video_service.find_video_by_country(country)

    video = if video_data[:items].any?
              Video.new(video_data)
            else
              {}
            end

    images_data = image_service.find_images_by_country(country)

    images = images_data[:results].map do |data|
      Image.new(data)
    end

    learning_resource_data = {
      country: country,
      video: video,
      images: images
    }

    learning_resource = LearningResource.new(learning_resource_data)

    render json: LearningResourceSerializer.new(learning_resource)
  end
end
