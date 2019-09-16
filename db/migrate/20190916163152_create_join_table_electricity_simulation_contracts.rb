class CreateJoinTableElectricitySimulationContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :join_table_electricity_simulation_contracts do |t|
      t.float :savings

      t.timestamps
    end
  end
end
