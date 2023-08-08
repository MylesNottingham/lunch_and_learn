class VideoService
  def find_video_by_country(country)
    channel_id = "UCluQ5yInbeAkkeCndNnUhpw"
    get_url("?key=#{ENV["YOUTUBE_API_KEY"]}&q=#{country}&channelId=#{channel_id}&part=snippet")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://www.googleapis.com/youtube/v3/search") do |faraday|
      faraday.params["accept"] = "application/json"
    end
  end
end
