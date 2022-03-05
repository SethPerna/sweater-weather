class Api::V1::ForecastController < ApplicationController
  before_action :check_location

  def index
    forecast = ForecastFacade.find_forecast(@coordinates[:lat], @coordinates[:lng])
    render json: ForecastSerializer.weather(forecast)
  end

  private

  def check_location
    if params[:location].present?
      @coordinates = LocationFacade.find_coords(params[:location])
    else
      render status: 404
    end
  end
end
