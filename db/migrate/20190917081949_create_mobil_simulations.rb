class CreateMobilSimulations < ActiveRecord::Migration[5.2]
  def change
    create_table :mobil_simulations do |t|
      t.string :name, default: "Electricité"
      t.float :actual_price_paid, default: 0.00
      t.float :mobil_cost_saved, default: 0.00
      t.boolean :calls_france, default: false
      t.boolean :calls_europe, default: false
      t.float :gbyte_europe, default: 0.00
      t.belongs_to :full_simulation, index: true
      t.timestamps
    end
  end
end
