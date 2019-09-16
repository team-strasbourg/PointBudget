class BoxSimulation < ApplicationRecord
  belongs_to :full_simulation
  has_many :join_table_box_contracts, dependent: :destroy
  has_many :box_contracts, through: :join_table_box_contracts
end
