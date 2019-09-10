class CreateJoinTableGasSimulationContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :join_table_gas_simulation_contracts do |t|
      t.belongs_to :gas_simulation
      t.belongs_to :gas_contract
      t.timestamps
    end
  end
end
