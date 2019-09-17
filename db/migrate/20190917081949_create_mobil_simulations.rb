class CreateMobilSimulations < ActiveRecord::Migration[5.2]
  def change
    create_table :mobil_simulations do |t|
      t.string :name
      t.float :actual_price_paid
      t.float :mobil_cost_saved
      t.boolean :calls_france
      t.boolean :calls_europe
      t.float :gbyte_europe

      t.timestamps
    end
  end
end
