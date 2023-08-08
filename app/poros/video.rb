class Video
  attr_reader :title,
              :youtube_video_id

  def initialize(params)
    @title = params[:items][0][:snippet][:title]
    @youtube_video_id = params[:items][0][:id][:videoId]
  end
end
