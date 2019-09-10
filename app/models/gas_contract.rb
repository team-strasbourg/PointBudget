class GasContract < ApplicationRecord
  has_many :join_table_gases
  has_many :gas_simulations, through: :join_table_gases

  validates :kw_consumption_per_year,
            numericality: { less_than_or_equal_to: 30, greater_than_or_equal_to: 1}
  validates :subscription_base_price_month,
            numericality: { less_than_or_equal_to: 40.00,
                            greater_than_or_equal_to: 6.00}

  validates :kwh_price_base,
            numericality: { less_than_or_equal_to:0.10000, greater_than_or_equal_to: 0.04000 }
end
