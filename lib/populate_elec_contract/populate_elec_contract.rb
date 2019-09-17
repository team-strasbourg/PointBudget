require 'csv'

data = CSV.read('./lib/populate_elec_contract/offer_electricity.csv',
headers: true, col_sep: ',', encoding: 'ISO-8859-1')
lines = data.reject { |line| line[0].blank? }

puts lines[3][2]

# Verifier les to_f!
EleContract.destroy_all
lines.each do |line|
EleContract.create(supplier: line[0],
     offer_name: line[1],
     kVA_power: line[2].to_i,
     subscription_base_price_month: line[3].to_f,
     kwh_price_base: line[4].to_f
     )
end

# create_table "ele_contracts", force: :cascade do |t|
#   t.string "supplier"
#   t.string "offer_name"
#   t.integer "kVA_power"
#   t.float "subscription_base_price_month"
#   t.float "kwh_price_base"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end