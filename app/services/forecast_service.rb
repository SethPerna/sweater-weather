class ForecastService
  def self.connection
    url = "https://api.openweathermap.org/data/2.5/onecall?"
    Faraday.new(url: url) do |faraday|
      faraday.params['appid'] = ENV['forecast_api_key']
    end
  end

  def self.get_forecast(latitude, longitude)
    response = connection.get do |faraday|
      faraday.params['lat'] = latitude
      faraday.params['lon'] = longitude
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
