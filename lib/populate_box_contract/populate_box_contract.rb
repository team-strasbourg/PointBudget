# BOX contract
require 'csv'

data = CSV.read('./lib/populate_box_contract/offer_box.csv',
                headers: true, col_sep: ',', encoding: 'ISO-8859-1')
lines = data.reject { |line| line[0].nil? }
puts lines
# BoxContract.destroy_all
# lines.each do |line|
#   BoxContract.create(supplier: line[0],
#                      offer_name: line[1],
#                      low_kw_consumption_per_year: line[2],
#                      high_kw_consumption_per_year: line[3],
#                      subscription_base_price_month: line[4],
#                      kwh_price_base: line[5])
# end
