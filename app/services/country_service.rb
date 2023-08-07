class CountryService
  def random_country
    get_names.sample
  end

  def get_capital(country)
    get_url("/v3.1/name/#{country.gsub(" ", "%20")}").first[:capital].first
  end

  private

  def get_names
    all = get_url("/v3.1/all")

    all.map do |country|
      country[:name][:common]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://restcountries.com")
  end
end
