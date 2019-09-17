# BOX contract
require 'csv'

data = CSV.read('./lib/populate_box_contract/offer_box.csv',
                headers: true, col_sep: ',', encoding: 'ISO-8859-1')
lines = data.reject { |line| line[0].blank? }

new_bool = lines[3][10]

def to_boolean(value)
  if value == "true"
    return true 
  elsif value == "false"  
    return false
  end
end
puts to_boolean(new_bool).class


# BoxContract.destroy_all
# lines.each do |line|
#   BoxContract.create(supplier: line[0],
#                      offer_name: line[1],
#                      price_month: line[2],
#                      engagement: line[3],
#                      price_after: line[4],
#                      type: line[5],
#                      downstream: line[6],
#                      upstream: line[7],
#                      tv_channel: line[8],
#                      tv: line[9],
#                      call_fix_fr: line[10],
#                      call_mobile_fr: line[11],
#                      call_foreign: line[12],
#                      opening_fee: line[13],
#                      termination_fee: line[14],
#                      taken_termination: line[15],
                     
#                      )
# end

# create_table "box_contracts", force: :cascade do |t|
#   t.string "supplier", default: ""
#   t.string "offer_name", default: ""
#   t.float "price_month", default: 0.0
#   t.integer "commitment", default: 0
#   t.float "price_after", default: 0.0
#   t.string "type", default: ""
#   t.integer "downstream", default: 0
#   t.integer "upstream", default: 0
#   t.string "tv_channel", default: ""
#   t.boolean "tv", default: false
#   t.boolean "call_fix_fr", default: false
#   t.boolean "call_mobile_fr", default: false
#   t.boolean "call_foreign", default: false
#   t.float "opening_fee", default: 0.0
#   t.float "termination_fee", default: 0.0
#   t.float "taken_termination", default: 0.0
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
