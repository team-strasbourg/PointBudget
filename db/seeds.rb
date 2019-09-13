# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
#


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


# City.destroy_all

# User.destroy_all

# 20.times do
#   City.create(name: Faker::Address.city, zip_code: '12345', insee_code: "12345")
# end
# puts 'City created'
# 20.times do
#   User.create(email: Faker::Internet.email,
#               password: Faker::Internet.password,
#               first_name: Faker::Name.first_name,
#               last_name: Faker::Name.last_name,
#               phone_number: %w[0606060606 +33606060606].sample,
#               city: City.all.sample)
#   print '#'
# end
# puts ''
# puts 'Users created'
# User.create(email: 'admin123@admin.com', password: 'admin123', city: City.first, is_admin: true)
# puts 'admin created'

require 'csv'

data = CSV.read('lib/populate_gas_contract/offer_gas.csv', {:headers => false, :col_sep => ',', :encoding => 'ISO-8859-1'})
lines =  data.select { |line| !line[0].nil?}
GasContract.destroy_all
lines.each do |line|
  GasContract.create(supplier: line[0],
                     offer_name: line[1],
                     low_kw_consumption_per_year: line[2],
                     high_kw_consumption_per_year: line[3],
                     subscription_base_price_month: line[4],
                     kwh_price_base: line[5]
  )
end
