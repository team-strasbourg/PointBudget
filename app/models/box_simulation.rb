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


  # This method is used to replace the value to show if there are not provided by the client
  def print_report
    table_attributes = []
    [tv, call_fix_fr, call_mob_fr].each do |attribute|
      table_attributes << attribute.presence || 'Non renseigné'
    end
    table_attributes
  end

  # Set the user of the box simulation
  def user
    self.full_simulation.user
  end

  def assign_params_from_controller(params)
    @params = params
  end

  # This method can show the top best contracts depending on the number we want to show
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

  # This method execute the comparison between what is entered by the client and the contracts
  def comparison(monthly_cost, tv, call_fix, call_mobile)
    monthly_cost = monthly_cost.to_i
    first_filter = BoxContract.all.select { |contract| contract.tv == tv }
    second_filter = first_filter.select { |contract| contract.call_fix_fr == call_fix }
    third_filter = second_filter.select { |contract| contract.call_mobile_fr == call_mobile }
    max_save = 0
    all_savings = []
    third_filter.each do |contract|
      savings = ((monthly_cost - contract.price_month) * 12 ).round(2)
      if savings > max_save
        max_save = savings
      end
      all_savings << savings
    end
    [max_save.round(2), third_filter, all_savings]
  end

  # This method create all the join table given by the filter and the saving associated with each
  def create_join_table_box(filter, all_savings)
    filter.each_with_index do |contract, index|
      JoinTableBoxContract.create(box_simulation: self, box_contract: contract, savings: all_savings[index])
    end
  end
end
