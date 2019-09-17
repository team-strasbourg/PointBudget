FactoryBot.define do
  factory :ele_simulation do
    actual_price_paid { 1.5 }
    ele_cost_saved { 1.5 }
    ele_use { 1 }
    name { "MyString" }
  end
end
