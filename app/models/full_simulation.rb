class FullSimulation < ApplicationRecord
  belongs_to :user
  has_one :gas_simulation

  def only_one_gas_simulation
    if gas_simulation == nil
      false
    else
    	true
    end
  end
end
