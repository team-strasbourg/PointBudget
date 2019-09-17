class MobilContract < ApplicationRecord
	has_many :join_table_mobil_contracts
  has_many :mobil_simulations, through: :join_table_mobil_contracts
end
