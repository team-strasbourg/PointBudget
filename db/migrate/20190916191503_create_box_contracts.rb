class CreateBoxContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :box_contracts do |t|
      t.string :supplier, default: ""
      t.string :offer_name, default: ""
      t.float :price_month, default: 0.00
      t.integer :commitment, default: 0
      t.float :price_after, default: 0.0
      t.string :type, default: ""
      t.integer :downstream, default: 0
      t.integer :upstream, default: 0
      t.string :tv_channel, default: ""
      t.boolean :tv, default: false
      t.boolean :call_fix_fr, default: false
      t.boolean :call_mobile_fr, default: false
      t.boolean :call_foreign, default: false
      t.float :opening_fee, default: 0.0
      t.float :termination_fee, default: 0.0
      t.float :taken_termination, default: 0.0

      t.timestamps
    end
  end
end
