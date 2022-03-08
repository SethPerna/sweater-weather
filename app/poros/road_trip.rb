class RoadTrip
  attr_reader :start, :end, :travel_eta, :temperature, :conditions
  def initialize(data, forecast)
    @start = start_city(data)
    @end = end_city(data)
    @travel_eta = travel_time(data)
    @temperature = get_forecast_temp(data, forecast)
    @conditions = get_forecast_conditions(data, forecast)
  end

  def start_city(data)
    "#{data[:route][:locations][0][:adminArea5]}, #{data[:route][:locations][0][:adminArea3]}"
  end

  def end_city(data)
    "#{data[:route][:locations][1][:adminArea5]}, #{data[:route][:locations][1][:adminArea3]}"
  end

  def travel_time(data)
    time = data[:route][:formattedTime]
    hours = time.slice(0..1)
    minutes = time.slice(3..4)
    "#{hours} hours, #{minutes} minutes"
  end

  def arrival_time(data)
    minute_round = 0
    time = data[:route][:formattedTime]
    hours = time.slice(0..1).to_i
    minutes = time.slice(3..4).to_i
    if minutes < 30
      minute_round = 0
    elsif minutes >= 30
      minute_round = 1
    end
    total_hours = hours + minute_round
  end

  def get_forecast_conditions(data, forecast)
    conditions = nil
    time_calc = arrival_time(data)
    if time_calc < 24
      conditions = forecast[:hourly][time_calc][:weather][0][:description]
    elsif time_calc >= 24
      conditions = forecast[:daily][1][:weather][0][:description]
    end
    conditions
  end

  def get_forecast_temp(data, forecast)
    temp = nil
    time_calc = arrival_time(data)
    if time_calc < 24
      temp = forecast[:hourly][time_calc][:temp]
    elsif time_calc >= 24
      temp = forecast[:daily][1][:temp][:day]
    end
    temp
  end
end
