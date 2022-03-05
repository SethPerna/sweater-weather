class BackgroundFacade
  def self.find_forecast(location)
    json = BackgroundService.get_image(location)
  end
end
