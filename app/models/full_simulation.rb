class FullSimulation < ApplicationRecord
  belongs_to :user
  has_one :gas_simulation
end
