FactoryBot.define do
  factory :box_simulation do
    actual_price_paid { 1.5 }
    box_cost_saved { 1.5 }
    tv { false }
    call_fix_fr { false }
    call_mob_fr { false }
  end
end
