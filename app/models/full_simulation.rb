# frozen_string_literal: true

class FullSimulation < ApplicationRecord
  belongs_to :user
  has_one :gas_simulation, dependent: :destroy
  has_one :ele_simulation, dependent: :destroy
  after_update :mail_if_validated

  validates :total_cost_saved,
            presence: true,
            numericality: { greater_than_or_equal_to: 0.00 }

  def only_one_gas_simulation
    gas_simulation.nil? ? false : true
  end

  private

  def mail_if_validated
    UserMailer.simulation_validated_email(user).deliver_now if validated
  end
end
