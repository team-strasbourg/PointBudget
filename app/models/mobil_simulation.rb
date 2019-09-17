class MobilSimulation < ApplicationRecord
	has_many :join_table_mobil_contracts
	has_many :mobil_contracts, through: :join_table_mobil_contracts
	belongs_to :full_simulation

	validates :actual_price_paid,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :box_cost_saved,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }
            
end
