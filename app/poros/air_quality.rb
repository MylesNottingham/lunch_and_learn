class AirQuality
  attr_reader :id,
              :city

  def initialize(params)
    @id = nil
    @city = params[:city]
    @params = params
  end

  def aqi
    if @params[:data][:overall_aqi]
      @params[:data][:overall_aqi].to_f
    else
      nil
    end
  end

  def pm25_concentration
    if @params[:data][:"PM2.5"][:concentration]
      @params[:data][:"PM2.5"][:concentration].to_f
    else
      nil
    end
  end

  def co_concentration
    if @params[:data][:CO][:concentration]
      @params[:data][:CO][:concentration].to_f
    else
      nil
    end
  end
end
