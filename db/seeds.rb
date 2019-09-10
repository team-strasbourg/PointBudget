# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# DON'T UNCOMMENTE THE CITIES SEED
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
