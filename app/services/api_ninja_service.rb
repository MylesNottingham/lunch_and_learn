class ApiNinjaService
  def air_quality(capital, country)
    tests = get_url("airquality?city=#{capital.gsub(" ", "%20")}&country=#{country.gsub(" ", "%20")}")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.api-ninjas.com/v1/") do |faraday|
      faraday.headers["X-Api-Key"] = ENV["API_NINJA_KEY"]
    end
  end
end
