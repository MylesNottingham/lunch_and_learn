class AirQualitySerializer
  include JSONAPI::Serializer

  attributes :city, :aqi, :pm25_concentration, :co_concentration
end
