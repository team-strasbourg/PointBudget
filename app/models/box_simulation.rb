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
  validates :tv,
            presence: true
  validates :call_fix_fr,
            presence: true
  validates :call_mob_fr,
            presence: true

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

  def comparison(monthly_cost, tv, call_fix, call_mobile)
    first_filter = BoxContract.all.select { |contract|
      contract.tv == tv && contract.call_fix_fr == call_fix && contract.call_mob_fr == call_mobile
    }
    max_save = 0
    all_savings = []
    first_filter.each do |contract|
      savings = ((monthly_cost - contract.price_month)*12 ).round(2)
      if savings > max_save
        max_save = savings
      end
      all_savings << savings
    end
    [max_save.round(2), first_filter, all_savings]
  end

  def create_join_table_box(filter, all_savings)
    filter.each_with_index do |contract, index|
      JoinTableBoxContract.create(box_simulation: self, box_contract: contract, savings: all_savings[index])
    end
  end
end
