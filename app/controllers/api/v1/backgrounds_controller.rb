class Api::V1::BackgroundsController < ApplicationController
  before_action :check_location

  def index
    background = BackgroundFacade.find_image(@location)
    render json: BackgroundSerializer.image(background, @location)
  end

  private

  def check_location
    if params[:location].present?
      @location = params[:location]
    else
      render status: 404
    end
  end
end
