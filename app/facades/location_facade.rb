class LocationFacade
  def self.find_coords(location)
    json = LocationService.get_coordinates(location)
    json[:results][0][:locations][0][:latLng]
  end
end
