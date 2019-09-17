class BoxSimulation < ApplicationRecord
  belongs_to :full_simulation
  has_many :join_table_box_contracts, dependent: :destroy
  has_many :box_contracts, through: :join_table_box_contracts

  validates :actual_price_paid,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  validates :box_cost_saved,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }


  def print_report
    table_attributes = []
    [tv, call_fix_fr, call_mob_fr].each do |attribute|
      table_attributes << attribute.presence || 'Non renseigné'
    end
    table_attributes
  end

  def user
    self.full_simulation.user
  end

  def assign_params_from_controller(params)
    @params = params
  end

  def sort_contracts(how_many)
    return_array = []
    contracts_sorted = join_table_box_contracts.sort_by(&:savings).reverse
    how_many.times do |i|
      return_array << BoxContract.find(contracts_sorted[i].box_contract_id)
    rescue
      return_array
    end
    return_array
  end

  def comparison(monthly_cost, tv, call_fix, call_mobile)
    monthly_cost = monthly_cost.to_i
    first_filter = BoxContract.all.select { |contract| contract.tv == tv } # Filter if the tv option is the same
    second_filter = first_filter.select { |contract| contract.call_fix_fr == call_fix } # filter by the call to fix phone number in france
    third_filter = second_filter.select { |contract| contract.call_mobile_fr == call_mobile } # filter by the call to mobile phone number in france
    fourth_filter = third_filter.select { |contract| contract.price_month < monthly_cost } # filter by price
    max_save = 0
    all_savings = []
    fourth_filter.each do |contract|
      savings = ((monthly_cost - contract.price_month) * 12 ).round(2) # Find the best price
      if savings > max_save
        max_save = savings # Save the best price
      end
      all_savings << savings # Save the differences in an array, it will be use after
    end
    [max_save.round(2), fourth_filter, all_savings] # return the max savec, all the better contracts and the savings for each contracts
  end

  def create_join_table_box(filter, all_savings)
    filter.each_with_index do |contract, index|
      JoinTableBoxContract.create(box_simulation: self, box_contract: contract, savings: all_savings[index])
    end
  end
end
