class Apartment
  attr_accessor :number, :furnished, :rent, :dogs_allowed, :number_of_rooms, :tenants

  def initialize(options={})
    @number = options[:number]
    @furnished = options[:furnished]
    @rent = options[:rent]
    @dogs_allowed = options[:dogs_allowed]
    @number_of_rooms = options[:number_of_rooms]
    @tenants = []
  end 
end