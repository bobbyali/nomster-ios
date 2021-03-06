class Place
  attr_accessor :lat, :long, :name, :address, :description, :id

  def initialize(lat, long, name, address, description, id)
    @name = name
    @address = address 
    @description = description 
    @id = id
    
    @coordinate = CLLocationCoordinate2D.new
    @coordinate.latitude = lat
    @coordinate.longitude = long
  end

  def title; @name; end
  def subtitle; @description; end
  def coordinate; @coordinate; end

  def url
    NSURL.alloc.initWithString("https://nomster-rehan-ali.herokuapp.com/places/#{self.id.to_s}")
  end

end