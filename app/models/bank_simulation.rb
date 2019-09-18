class BankSimulation < ApplicationRecord
  belongs_to :full_simulation
  has_many :join_table_bank_contracts
  has_many :bank_contracts, through: :join_table_bank_contracts
end

# Set the user of the box simulation
def user
  self.full_simulation.user
end

def comparison(accounting_fees, inactive_accounting_fees, price_cheque,insurance_payment, sms_alert, international_withdraw)
  first_filter = BankContract.all.select{|contract| contract.accounting_fees < accounting_fees }
  second_filter = first_filter.select{|contract| contract.inactive_accounting_fees < inactive_accounting_fees }
  third_filter = second_filter.select{|contract| contract.price_cheque < price_cheque }
  fourth_filter = third_filter.select{|contract| contract.insurance_payment < insurance_payment }
  fifth_filter = fourth_filter.select{|contract| contract.sms_alert < sms_alert }
  sixth_filter = fifth_filter.select{|contract| contract.international_withdraw < international_withdraw }

  price_paid = accounting_fees + inactive_accounting_fees + price_cheque + insurance_payment + sms_alert + international_withdraw
  max_save = 0
  all_savings = []
  sixth_filter.each do |contract|
    price_contract = contract.accounting_fees + contract.inactive_accounting_fees + contract.price_cheque + contract.insurance_payment + contract.sms_alert + contract.international_withdraw
    savings = (price_paid - price_contract ).round(2) # Find the best price
    if savings > max_save
      max_save = savings # Save the best price
    end
    all_savings << savings # Save the differences in an array, it will be use after
  end
  [max_save.round(2), sixth_filter, all_savings] # return the max savec, all the better contracts and the savings for each contracts
end

# This method can show the top best contracts depending on the number we want to show
def sort_contracts(how_many)
  return_array = []
  contracts_sorted = join_table_bank_contracts.sort_by(&:savings).reverse
  how_many.times do |i|
    return_array << BankContract.find(contracts_sorted[i].bank_contract_id)
  rescue
    return_array
  end
  return_array
end

# This method create all the join table given by the filter and the saving associated with each
def create_join_table_bank(filter, all_savings)
  filter.each_with_index do |contract, index|
    JoinTableBankContract.create(bank_simulation: self, bank_contract: contract, savings: all_savings[index])
  end
end