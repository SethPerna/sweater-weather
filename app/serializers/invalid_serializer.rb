class InvalidSerializer
  def self.road_trip(road_trip)
    { "data":
      {
        "id": nil,
        "type": "roadtrip",
        "attributes":
        {
          "start_city": "",
          "end_city": "",
          "travel_time": "Impossible",
          "weather_at_eta":
          {
            "temperature": "",
            "conditions": ""
          }
        }
      }
    }
  end
end
