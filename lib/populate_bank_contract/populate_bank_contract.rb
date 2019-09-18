require 'csv'

data = CSV.read('./lib/populate_bank_contract/offer_bank.csv',
                headers: true, col_sep: ',', encoding: 'ISO-8859-1')
lines = data.reject { |line| line[0].nil? }


# BankContract.destroy_all
lines.each do |line|
  puts line
  # BankContract.create(supplier: line[0],
  #     group_name: line[1],
  #     accounting_fees: line[2].to_f,
  #     inactive_accounting_fees: line[3].to_f,
  #     cheque: ActiveModel::Type::Boolean.new.cast line[4].to_i,
  #     price_cheque: line[5].to_f,
  #     price_order_cheque: line[6].to_s,
  #     insurance_payment: line[7].to_i,
  #     sms_alert: line[8].to_i,
  #     international_withdraw: line[9])
end
