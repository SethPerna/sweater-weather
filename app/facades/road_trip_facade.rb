class RoadTripFacade
  def self.get_road_trip(to, from)
    data = RoadTripService.find_road_trip(to, from)
  end
end
