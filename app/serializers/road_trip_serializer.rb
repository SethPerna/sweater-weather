class RoadTripSerializer
  def self.road_trip(trip)
    { "data":
      {
        "id": nil,
        "type": "roadtrip",
        "attributes":
        {
          "start_city": trip.start,
          "end_city": trip.end,
          "travel_time": trip.travel_eta,
          "weather_at_eta":
          {
            "temperature": trip.temperature,
            "conditions": trip.conditions
          }
        }
      }
    }
  end

  # def self.start_city(road_trip)
  #   "#{road_trip[:route][:locations][0][:adminArea5]}, #{road_trip[:route][:locations][0][:adminArea3]}"
  # end
  #
  # def self.end_city(road_trip)
  #   "#{road_trip[:route][:locations][1][:adminArea5]}, #{road_trip[:route][:locations][1][:adminArea3]}"
  # end
  #
  # def self.travel_time(road_trip)
  #   time = road_trip[:route][:formattedTime]
  #   hours = time.slice(0..1)
  #   minutes = time.slice(3..4)
  #   "#{hours} hours, #{minutes} minutes"
  # end

  # def self.arrival_time(road_trip)
  #   minute_round = 0
  #   time = road_trip[:route][:formattedTime]
  #   hours = time.slice(0..1).to_i
  #   minutes = time.slice(3..4).to_i
  #   if minutes < 30
  #     minute_round = 0
  #   elsif minutes >= 30
  #     minute_round = 1
  #   end
  #   total_hours = hours + minute_round
  # end
  #
  # def self.get_forecast_conditions(road_trip, forecast)
  #   conditions = nil
  #   time_calc = self.arrival_time(road_trip)
  #   if time_calc < 24
  #     conditions = forecast[:hourly][time_calc][:weather][0][:description]
  #   elsif time_calc >= 24
  #     conditions = forecast[:daily][1][:weather][0][:description]
  #   end
  #   conditions
  # end
  #
  # def self.get_forecast_temp(road_trip, forecast)
  #   temp = nil
  #   time_calc = self.arrival_time(road_trip)
  #   if time_calc < 24
  #     temp = forecast[:hourly][time_calc][:temp]
  #   elsif time_calc >= 24
  #     temp = forecast[:daily][1][:temp][:day]
  #   end
  #   temp
  # end
end
