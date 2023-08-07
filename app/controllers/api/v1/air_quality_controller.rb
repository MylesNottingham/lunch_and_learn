class Api::V1::AirQualityController < ApplicationController
  def index
    api_ninja_service = ApiNinjaService.new

    if params[:country]
      country = params[:country]
    else
      country = CountryService.new.random_country
    end

    capital = CountryService.new.get_capital(country)

    air_quality_data = api_ninja_service.air_quality(capital, country)

    air_quality_params = {
      data: air_quality_data,
      city: capital
    }

    air_quality = AirQuality.new(air_quality_params)

    render json: AirQualitySerializer.new(air_quality)
  end
end
