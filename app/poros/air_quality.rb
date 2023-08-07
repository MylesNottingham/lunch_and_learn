class AirQuality
  attr_reader :id,
              :city,
              :aqi,
              :pm25_concentration,
              :co_concentration

  def initialize(params)
    @id = nil
    @city = params[:city]
    @aqi = params[:data][:overall_aqi]
    @pm25_concentration = params[:data][:"PM2.5"][:concentration]
    @co_concentration = params[:data][:CO][:concentration]
  end
end
