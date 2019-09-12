class FullSimulation < ApplicationRecord
  belongs_to :user
  has_one :gas_simulation
  after_update :mail_if_validated

  def only_one_gas_simulation
    gas_simulation.nil? ? false : true
  end

  private

  def mail_if_validated
    UserMailer.simulation_validated_email(self.user).deliver_now if validated
  end
end
