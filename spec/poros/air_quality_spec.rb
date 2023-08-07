require "rails_helper"

RSpec.describe AirQuality, type: :poro do
  it "can instantiate with given attributes" do
    data = {
      overall_aqi: 20,
      "PM2.5": {
        concentration: 0.5
      },
      CO: {
        concentration: 0.1
      }
    }

    params = {
      data: data,
      city: "Denver"
    }

    air_quality = AirQuality.new(params)

    expect(air_quality).to be_a(AirQuality)
    expect(air_quality.id).to be_nil
    expect(air_quality.city).to eq("Denver")
    expect(air_quality.aqi).to eq(20.0)
    expect(air_quality.pm25_concentration).to eq(0.5)
    expect(air_quality.co_concentration).to eq(0.1)
  end

  it "can instantiate with given attributes with nil values" do
    data = {
      overall_aqi: nil,
      "PM2.5": {
        concentration: nil
      },
      CO: {
        concentration: nil
      }
    }

    params = {
      data: data,
      city: "Denver"
    }

    air_quality = AirQuality.new(params)

    expect(air_quality).to be_a(AirQuality)
    expect(air_quality.id).to be_nil
    expect(air_quality.city).to eq("Denver")
    expect(air_quality.aqi).to be_nil
    expect(air_quality.pm25_concentration).to be_nil
    expect(air_quality.co_concentration).to be_nil
  end
end
