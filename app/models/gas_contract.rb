class GasContract < ApplicationRecord
  has_many :join_table_gases
  has_many :gas_simulations, through: :join_table_gases

  validates :kw_consumption_per_year,
            numericality: { less_than_or_equal_to: 30, greater_than_or_equal_to: 1}
end
