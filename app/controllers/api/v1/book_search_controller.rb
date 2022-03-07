class Api::V1::BookSearchController < ApplicationController
  before_action :check_location

  def index
    location = params[:location]
    quantity = params[:quantity].to_i
    forecast = ForecastFacade.find_forecast(@coordinates[:lat], @coordinates[:lng])
    books = BookFacade.find_books(location)
    if quantity <= books[:numFound]
      render json: BooksSerializer.book_response(forecast, books, location, quantity)
    else
      return invalid_quantity
    end
  end

  private

  def check_location
    if params[:location].present?
      @coordinates = LocationFacade.find_coords(params[:location])
    else
      render status: 404
    end
  end

  def invalid_quantity
    render json: { data: { message: 'Invalid Quantity' } }
  end
end
