require 'rails_helper'
RSpec.describe BackgroundFacade do
 it ".find_image", :vcr do
   image = BackgroundFacade.find_image("Denver,Co")
   expect(image[:photos][0]).to have_key(:photographer_url)
   expect(image[:photos][0]).to have_key(:photographer)
   expect(image[:photos][0][:src]).to have_key(:small)
  end
end
