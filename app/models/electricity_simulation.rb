class ElectricitySimulation < ApplicationRecord
  belongs_to :full_simulation
  has_many :join_table_elec_simulation_contracts, dependent: :destroy
  has_many :elec_contracts, through: :join_table_elec_simulation_contracts
end
