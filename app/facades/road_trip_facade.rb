class RoadTripFacade
  def self.get_road_trip(to, from)
    RoadTripService.find_road_trip(to, from)
  end
end
