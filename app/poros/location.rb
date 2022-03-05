class Location
  attr_reader :longitude, :latitude
  def initialize(data)
    @longitude = data[:lng]
    @latitude = data[:lat]
  end
end
