class CreateJoinTableMobilContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :join_table_mobil_contracts do |t|
      t.float :savings

      t.timestamps
    end
  end
end
