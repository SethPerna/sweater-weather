class RoadTripService
  def self.connection
    url = "http://www.mapquestapi.com/directions/v2/route"
    Faraday.new(url: url) do |faraday|
      faraday.params['key'] = ENV['map_api_key']
    end
  end

  def self.find_road_trip(origin, destination)
    response = connection.get do |faraday|
      faraday.params['from'] = origin
      faraday.params['to'] = destination
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
