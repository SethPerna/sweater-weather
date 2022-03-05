require 'rails_helper'

RSpec.describe Location do
  it 'exists' do
    location = {:lat=>39.738453, :lng=>-104.984853}

    coords = Location.new(location)
    expect(coords).to be_a Location
    expect(coords.latitude).to eq(location[:lat])
    expect(coords.longitude).to eq(location[:lng])
  end
end
