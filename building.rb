class Building
  attr_accessor :address, :sqft, :no_of_stories, :apartments
  def initialize(options={})
    @address= options[:address]
    @sqft = options[:sqft]
    @no_of_stories = options[:no_of_stories]
    @apartments = {}
  end

  def total_income
    apt_cost_array = apartments.map do |apartment_key, apartment_value|
      apartment_value.tenants.length * apartment_value.rent
    end
    apt_cost_array.inject(:+)
  end

  def get_all_tenants
    nested_tenants_array = apartments.map do |apartment_key, apartment_value|
      apartment_value.tenants
    end
    nested_tenants_array.flatten
  end

  def available_apartments
    apartments.select do |apartment_key, apartment_value|
      apartment_value.tenants.count < apartment_value.number_of_rooms
    end
  end

  def evict_tenants
    evicted_tenants = []
    apartments.each do |apartment_key, apartment_value|
      evicted_tenants << apartment_value.tenants
      apartment_value.tenants = []
    end
    evicted_tenants
  end

  def display_occupancies
    apartments.group_by do |apartment_key, apartment_value|
      apartment_value.tenants.count < apartment_value.number_of_rooms
    end
  end
end