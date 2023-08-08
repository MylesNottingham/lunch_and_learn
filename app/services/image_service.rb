class ImageService
  def find_images_by_country(country)
    get_url("search/photos/?query=#{country}&client_id=#{ENV['UNSPLASH_API_KEY']}")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.unsplash.com/") do |faraday|
      faraday.params["Accept-Version"] = "v1"
    end
  end
end
