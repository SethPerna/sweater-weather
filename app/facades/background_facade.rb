class BackgroundFacade
  def self.find_image(location)
    json = BackgroundService.get_image(location)
  end
end
