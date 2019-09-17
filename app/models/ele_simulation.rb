class EleSimulation < ApplicationRecord
  belongs_to :full_simulation
  has_many :join_table_ele_simulation_contracts, dependent: :destroy
  has_many :ele_contracts, through: :join_table_ele_simulation_contracts
end
