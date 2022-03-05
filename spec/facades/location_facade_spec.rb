require 'rails_helper'
RSpec.describe LocationFacade do
 it ".find_coords", :vcr do
   coords = LocationFacade.find_coords("Denver,Co")
   expect(coords).to be_a(Location)
  end
end
