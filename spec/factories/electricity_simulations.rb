FactoryBot.define do
  factory :electricity_simulation do
    actual_price_paid { 1.5 }
    elec_cost_saved { 1.5 }
    elec_use { 1 }
    name { "MyString" }
  end
end
