FactoryBot.define do
  factory :join_table_gas_simulation_contract do
    gas_simulation { create(:gas_simulation)}
    gas_simulation { create(:gas_contract)}
  end
end
