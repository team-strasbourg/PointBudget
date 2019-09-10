FactoryBot.define do
  factory :full_simulation do
    total_cost_saved { 1.56 }
    validated { false }

    factory :full_simulation_bad_cost do
      total_cost_saved {1.5}
    end


  end
end
