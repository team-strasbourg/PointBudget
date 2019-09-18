class BankSimulation < ApplicationRecord
  belongs_to :full_simulation
  has_many :join_table_bank_contracts
  has_many :bank_contracts, through: :join_table_bank_contracts
end
