require 'rails_helper'
RSpec.describe ForecastFacade do
 it ".find_forecast", :vcr do
   data = {:lat=>39.738453, :lng=>-104.984853}
   forecast = ForecastFacade.find_forecast(data[:lat], data[:lng])
   expect(forecast).to be_a Hash
   expect(forecast).to_not have_key(:minutely)
   expect(forecast[:current]).to have_key(:dt)
   expect(forecast[:current]).to have_key(:sunrise)
   expect(forecast[:current]).to have_key(:sunset)
   expect(forecast[:current]).to have_key(:temp)
   expect(forecast[:current]).to have_key(:feels_like)
   expect(forecast[:current]).to have_key(:humidity)
   expect(forecast[:current]).to have_key(:uvi)
   expect(forecast[:current]).to have_key(:visibility)
   expect(forecast[:current][:weather][0]).to have_key(:description)
   expect(forecast[:current][:weather][0]).to have_key(:icon)
  end
end
