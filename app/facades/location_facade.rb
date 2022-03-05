class LocationFacade
  def self.find_coords(location)
    json = LocationService.get_coordinates(location)
    Location.new(json[:results][0][:locations][0][:latLng])
  end
end
