require 'rails_helper'
RSpec.describe LocationFacade do
 it ".find_coords", :vcr do
   coords = LocationFacade.find_coords("Denver,Co")

   expect(coords).to eq({:lat=>39.738453, :lng=>-104.984853})
  end
end
