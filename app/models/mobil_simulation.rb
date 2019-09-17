class MobilSimulation < ApplicationRecord
	has_many :join_table_mobil_contracts
	has_many :mobil_contracts, through: :join_table_mobil_contracts
	belongs_to :full_simulation
end
