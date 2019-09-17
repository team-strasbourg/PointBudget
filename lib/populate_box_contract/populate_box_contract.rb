require 'csv'

data = CSV.read('./lib/populate_box_contract/offer_box.csv',
                headers: true, col_sep: ',', encoding: 'ISO-8859-1')
lines = data.reject { |line| line[0].blank? }

def to_boolean(value)
  if value == "true"
    return true 
  elsif value == "false"  
    return false
  end
end

BoxContract.destroy_all
lines.each do |line|
  BoxContract.create(supplier: line[0],
                     offer_name: line[1],
                     price_month: line[2].to_i,
                     engagement: line[3].to_i,
                     price_after: line[4].to_i,
                     type: line[5],
                     downstream: line[6].to_i,
                     upstream: line[7].to_i,
                     tv_channel: line[8],
                     tv: to_boolean(line[9]),
                     call_fix_fr: to_boolean(line[10]),
                     call_mobile_fr: to_boolean(line[11]),
                     call_foreign: to_boolean(line[12]),
                     opening_fee: line[13].to_i,
                     termination_fee: line[14].to_i,
                     taken_termination: line[15].to_i
                     )
end
