FactoryBot.define do
  factory :gas_simulation do
    actual_price_paid { 1.5 }
    gas_cost_saved { 1.5 }
    floor_space { 1 }
    heat_type { "MyString" }
    string { "MyString" }
    water_cooking_type { "MyString" }
    residents_number { 1 }
    gas_use { 1 }
  end
end
