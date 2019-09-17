require 'csv'

data = CSV.read('./lib/populate_mobile_contract/offer_mobile.csv',
headers: true, col_sep: ',', encoding: 'ISO-8859-1')
lines = data.reject { |line| line[0].blank? }
puts lines

# EleContract.destroy_all
# lines.each do |line|
#   EleContract.create(supplier: line[0],
#       offer_name: line[1],
#       kVA_power: line[2].to_i,
#       subscription_base_price_month: line[3].to_f,
#       kwh_price_base: line[4].to_f
#       )
# end
