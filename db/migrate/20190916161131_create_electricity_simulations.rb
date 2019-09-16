class CreateElectricitySimulations < ActiveRecord::Migration[5.2]
  def change
    create_table :electricity_simulations do |t|
      t.float :actual_price_paid
      t.float :elec_cost_saved
      t.integer :elec_use
      t.belongs_to :full_simulation, index: true

      t.timestamps
    end
  end
end