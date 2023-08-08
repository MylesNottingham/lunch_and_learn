class RecipeService
  def find_recipe_by_country(country)
    get_url("?type=public&q=#{country.gsub(' ', '%20')}")
  end

  private

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.edamam.com/api/recipes/v2") do |faraday|
      faraday.params["app_id"] = ENV["EDAMAM_APP_ID"]
      faraday.params["app_key"] = ENV["EDAMAM_APP_KEY"]
    end
  end
end
