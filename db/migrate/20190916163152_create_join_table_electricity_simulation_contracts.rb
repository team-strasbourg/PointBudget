class CreateJoinTableElectricitySimulationContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :join_table_electricity_simulation_contracts do |t|
      t.float :savings, :float, default: 0.00

      t.timestamps
    end
  end
end
