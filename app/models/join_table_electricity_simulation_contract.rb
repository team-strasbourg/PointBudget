class JoinTableElectricitySimulationContract < ApplicationRecord
  has_many :join_table_electricity_simulation_contracts, dependent: :destroy
  has_many :electricity_simulations, through: :join_table_electricity_simulation_contracts

  validates :subscription_base_price_month,
            numericality: { less_than_or_equal_to: 40.00,
                            greater_than_or_equal_to: 6.00 }
  validates :kwh_price_base,
            numericality: { less_than_or_equal_to: 0.10000, greater_than_or_equal_to: 0.04000 }
end
