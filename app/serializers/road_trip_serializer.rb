class RoadTripSerializer
  def self.road_trip(road_trip, forecast)
    { "data":
      {
        "id": nil,
        "type": "roadtrip",
        "attributes":
        {
          "start_city": self.start_city(road_trip),
          "end_city": self.end_city(road_trip),
          "travel_time": self.travel_time(road_trip),
          "weather_at_eta":
          {
            "temperature": self.get_forecast_temp(road_trip, forecast),
            "conditions": self.get_forecast_conditions(road_trip, forecast)
          }
        }
      }
    }
  end

  def self.start_city(road_trip)
    "#{road_trip[:route][:locations][0][:adminArea5]}, #{road_trip[:route][:locations][0][:adminArea3]}"
  end

  def self.end_city(road_trip)
    "#{road_trip[:route][:locations][1][:adminArea5]}, #{road_trip[:route][:locations][1][:adminArea3]}"
  end

  def self.travel_time(road_trip)
    time = road_trip[:route][:formattedTime]
    hours = time.slice(0..1)
    minutes = time.slice(3..4)
    "#{hours} hours, #{minutes} minutes"
  end

  def self.arrival_time(road_trip)
    minute_round = 0
    time = road_trip[:route][:formattedTime]
    hours = time.slice(0..1).to_i
    minutes = time.slice(3..4).to_i
    if minutes < 30
      minute_round = 0
    elsif minutes >= 30
      minute_round = 1
    end
    total_hours = hours + minute_round
  end

  def self.get_forecast_conditions(road_trip, forecast)
    conditions = nil
    time_calc = self.arrival_time(road_trip)
    if time_calc < 48
      conditions = forecast[:hourly][time_calc][:weather][0][:description]
    elsif time_calc >= 48
      conditions = forecast[:daily][2][:weather][0][:description]
    end
    conditions
  end

  def self.get_forecast_temp(road_trip, forecast)
    temp = nil
    time_calc = self.arrival_time(road_trip)
    if time_calc < 48
      temp = forecast[:hourly][time_calc][:temp]
    elsif time_calc >= 48
      temp = forecast[:daily][2][:temp][:day]
    end
    temp
  end
end
