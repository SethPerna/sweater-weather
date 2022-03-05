require 'rails_helper'

RSpec.describe 'Background Service' do
  it 'returns a faraday response', :vcr do
      connection = BackgroundService.connection
      expect(connection).to be_a(Faraday::Connection)
  end

  it 'returns forecast data form longitude and latitude', :vcr do
    data = ('denver,co')
    background = BackgroundService.get_image(data)

    expect(background[:photos][0]).to have_key(:photographer_url)
    expect(background[:photos][0]).to have_key(:photographer)
    expect(background[:photos][0][:src]).to have_key(:small)
  end
end
