# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# DON'T UNCOMMENT THE CITIES SEED
# require 'rest-client'
# City.destroy_all
# cities_url = "https://geo.api.gouv.fr/communes"
# data = JSON.parse( RestClient.get(cities_url) )
# data.each do |city|
#   if city["codesPostaux"][0].nil?
#     City.create(name: city["nom"], insee_code: city["code"], zip_code: city["code"])
#   else
#     City.create(name: city["nom"], insee_code: city["code"], zip_code: city["codesPostaux"][0])
#   end
# end
#

City.destroy_all

User.destroy_all

20.times do
  City.create(name: Faker::Address.city, zip_code: '12345', insee_code: "12345")
end
puts 'City created'
20.times do
  User.create(email: Faker::Internet.email,
              password: Faker::Internet.password,
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              phone_number: %w[0606060606 +33606060606].sample,
              city: City.all.sample)
  print '#'
end
puts ''
puts 'Users created'
User.create(email: 'admin123@admin.com', password: 'admin123', city: City.first, is_admin: true)
puts 'admin created'

