class GazContract < ApplicationRecord
  has_many :join_table_gases
  has_many :gas_simulations, through: :join_table_gases
end
