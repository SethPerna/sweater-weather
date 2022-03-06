require 'rails_helper'
RSpec.describe ForecastFacade do
 it ".get_road_trip", :vcr do
   origin = 'denver,co'
   destination = 'pueblo,co'
   roadtrip = RoadTripFacade.get_road_trip(origin, destination)
   expect(roadtrip).to be_a(Hash)
   expect(roadtrip).to have_key(:route)
   expect(roadtrip[:route]).to have_key(:formattedTime)
   expect(roadtrip[:route]).to have_key(:locations)
  end
end
