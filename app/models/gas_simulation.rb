class GasSimulation < ApplicationRecord
  belongs_to :full_simulation
  has_many :join_table_gases
  has_many :gas_contracts, through: :join_table_gases
end
