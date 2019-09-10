class CreateFullSimulations < ActiveRecord::Migration[5.2]
  def change
    create_table :full_simulations do |t|
      t.float :total_cost_saved
      t.boolean :validated

      t.timestamps
    end
  end
end
