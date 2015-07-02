require 'pry-byebug'
require_relative 'building'
require_relative 'apartment'
require_relative 'tenant'

#Whenever you create a new tenant, push the tenant into the tenants array;
tenants = []

building1 = Building.new({
  address: '110 Farringdon Road',
  sqft: 10000,
  no_of_stories: 9
  })

apartment1 = Apartment.new({
  number: 1,
  furnished: true,
  rent: 2000,
  dogs_allowed: false,
  number_of_rooms: 2
  })

apartment2 = Apartment.new({
  number: 2,
  furnished: false,
  rent: 200,
  dogs_allowed: true,
  number_of_rooms: 2
  })

apartment3 = Apartment.new({
  number: 3,
  furnished: false,
  rent: 200,
  dogs_allowed: true,
  number_of_rooms: 2
  })

#Placing an apartment into the building
building1.apartments[apartment1.number] = apartment1
building1.apartments[apartment2.number] = apartment2
building1.apartments[apartment3.number] = apartment3

tenant1 = Tenant.new({
  name: 'Sam',
  smoker: false,
  age: 43,
  gender: 'male'
  })

tenant2 = Tenant.new({
  name: 'Jarkyn',
  smoker: false,
  age: 27,
  gender: 'female'
  })

# tenants << tenant1 << tenant2

#Placing tenants into apartments
building1.apartments[1].tenants.push(tenant1)
building1.apartments[1].tenants.push(tenant2)

def menu
  puts `clear`
  puts "-" * 80
  print "create a new (ap)artment \nregister a new (t)enant \n(a)dd tenant into an apartment \n(l)list tenants in the building\n(i)ncome for building\n(e)vict all tenants\n(d)isplay number of occupied and vacant flats\n(q)uit \n"
  puts "-" * 80
  response = gets.chomp
end

response = menu

while response != 'q'
  case response
  when 'ap'
    puts "You need to create a new apartment and add it to the building :-)"
  when 't'
    puts "What is the name of the tenant? \n"
    tenant_name = gets.chomp
    puts "What is the gender of the tenant? \n"
    gender = gets.chomp
    puts "Is the tenant a smoker (y)es (n)o? \n"
    smoker = (gets.chomp == "y")
    puts "What is the age of the tenant? \n"
    age = gets.chomp.to_i
    #Instantiating a new tenant object(remember when you instantiate an object, the initialize method will be called)
    tenant = Tenant.new({
      name: tenant_name,
      gender: gender,
      smoker: smoker,
      age: age
      })
    #Pushing the tenant into the tenants array(defined on line 7);
    tenants.push(tenant)
    puts "You have just added a new tenant #{tenant.name}"
  when 'a'
    if tenants.length < 1
      puts "There are currently no tenants to add to an apartment"
    else
      puts "select a tenant: \n"
      tenants.each_with_index do |tenant, index|
        puts "(#{index}) #{tenant.name} \n"
      end
      #Delete the tenant from the array and store into a variable
      tenant = tenants.delete_at(gets.chomp.to_i)
      puts "Choose an apartment number: \n"
      #Store all of the available apartments in an array
      available_apartments = building1.available_apartments
      available_apartments.each do |apartment_key, apartment_value|
        puts "(#{apartment_value.number}) \n"
      end
      apartment = gets.chomp.to_i
      building1.apartments[apartment].tenants << tenant
      puts "You just added #{tenant.name} to apartment number #{apartment}"
    end
  when 'l'
    #List all the tenants who are living in apartments in the building
    tenants_array = building1.get_all_tenants
    tenants_array.each do |tenant|
      puts "#{tenant.name}, #{tenant.age} years old, #{tenant.gender}"
    end
  when 'i'
    total_income = building1.total_income
    puts "The building is currently making #{total_income} per month"
  when 'e'
    #Evict everyone from the building
    evicted_tenants = building1.evict_tenants
    tenants << evicted_tenants.flatten
    binding.pry
    puts "WARNING all tenants have been evicted from the building!!"
  when 'd'
    result = building1.display_occupancies
    puts "#{result[true].count} apartments with vacancies" if result[true]
    puts "#{result[false].count} apartments without vacancies" if result[false]
  end

  puts "-" * 80
  puts "press enter to continue"
  gets
  response = menu
end
