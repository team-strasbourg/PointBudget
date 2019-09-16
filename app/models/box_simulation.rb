class BoxSimulation < ApplicationRecord
  belongs_to :full_simulation
  has_many :join_table_box_contracts, dependent: :destroy
  has_many :box_contracts, through: :join_table_box_contracts

  def print_report
    table_attributes = []
    [tv, call_fix_fr, call_mob_fr].each do |attribute|
      table_attributes << attribute.presence || 'Non renseigné'
    end
    table_attributes
  end
end
