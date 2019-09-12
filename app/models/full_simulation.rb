class FullSimulation < ApplicationRecord
  belongs_to :user
  has_one :gas_simulation
  after_update :mail_if_validated

  def only_one_gas_simulation
    if gas_simulation == nil
      false
    else
    	true
    end
  end

  private

  def mail_if_validated
    if validated
      UserMailer.simulation_validated_email(self.user).deliver_now
    end
  end
end
