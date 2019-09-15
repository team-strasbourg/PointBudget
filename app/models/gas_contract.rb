# frozen_string_literal: true

class GasContract < ApplicationRecord
  has_many :join_table_gases, dependent: :destroy
  has_many :gas_simulations, through: :join_table_gases

  validates :subscription_base_price_month,
            numericality: { less_than_or_equal_to: 40.00,
                            greater_than_or_equal_to: 6.00 }
  validates :kwh_price_base,
            numericality: { less_than_or_equal_to: 0.10000, greater_than_or_equal_to: 0.04000 }
end
