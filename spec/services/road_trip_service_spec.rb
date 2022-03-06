require 'rails_helper'

RSpec.describe 'RoadTrip Service' do
  it 'returns a faraday response', :vcr do
      connection = RoadTripService.connection
      expect(connection).to be_a(Faraday::Connection)
  end

  it 'returns forecast data form longitude and latitude', :vcr do
    origin = 'denver,co'
    destination = 'pueblo,co'
    roadtrip = RoadTripService.find_road_trip(origin, destination)
    expect(roadtrip).to be_a(Hash)
    expect(roadtrip).to have_key(:route)
    expect(roadtrip[:route]).to have_key(:formattedTime)
    expect(roadtrip[:route]).to have_key(:locations)
  end
end
