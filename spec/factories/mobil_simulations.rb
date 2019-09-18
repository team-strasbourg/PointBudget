FactoryBot.define do
  factory :mobil_simulation do
    name { "MyString" }
    actual_price_paid { 1.5 }
    mobil_cost_saved { 1.5 }
    calls_france { false }
    calls_europe { false }
    gbyte_europe { 1.5 }
  end
end
