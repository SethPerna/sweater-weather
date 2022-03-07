class Api::V1::BookSearchController < ApplicationController
  before_action :check_location

  def index
    location = params[:location]
    quantity = params[:quantity].to_i
    forecast = ForecastFacade.find_forecast(@coordinates[:lat], @coordinates[:lng])
    books = BookFacade.find_books(location)
    render json: BooksSerializer.book_response(forecast, books, location, quantity)
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
