class Api::V1::RoadTripController < ApplicationController
  before_action :validate_api_key
  def create
    to = params[:origin]
    from = params[:destination]
    road_trip = RoadTripFacade.get_road_trip(to, from)
    if road_trip[:info][:statuscode] == 402
      return invalid_location(road_trip)
    elsif
      lat_lng = road_trip[:route][:locations][1][:latLng]
      forecast = ForecastFacade.find_forecast(lat_lng[:lat], lat_lng[:lng])
      render json: RoadTripSerializer.road_trip(road_trip, forecast)
    end

  end

  private

  def validate_api_key
    @user = User.find_by(auth_token: params[:api_key])
    return invalid_api_key if @user.nil?
  end

  def invalid_api_key
    render json: { data: { message: 'Invalid API Key' } }
  end

  def invalid_location(road_trip)
    render json: InvalidSerializer.road_trip(road_trip)
  end
end
