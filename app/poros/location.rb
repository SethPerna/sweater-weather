class Location
  attr_reader :longitude, :lattitude
  def initialize(data)
    @longitude = data[:lng]
    @lattitude = data[:lat]
  end
end
