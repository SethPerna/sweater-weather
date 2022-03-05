require 'rails_helper'

RSpec.describe 'Forecast Service' do
  it 'returns a faraday response', :vcr do
      connection = ForecastService.connection
      expect(connection).to be_a(Faraday::Connection)
  end

  it 'returns longitude and lattitude', :vcr do
    get_location = ForecastService.get_coordinates("Denver,CO")
    expect(get_location).to be_a Hash
    expect(get_location[:results]).to be_a Array
    expect(get_location[:results][0][:locations][0][:latLng]).to have_key(:lat)
    expect(get_location[:results][0][:locations][0][:latLng]).to have_key(:lng)
  end
end
