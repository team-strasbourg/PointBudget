FactoryBot.define do
  factory :mobil_contract do
    supplier { "MyString" }
    offer_name { "MyString" }
    line_service_price { 1 }
    sim_card_price { 1 }
    engagement { false }
    add_phone { false }
    bundle_price { 1.5 }
    bundle_gbyte { 1.5 }
    calls_france { false }
    calls_europe { false }
    gbyte_europe { 1.5 }
    calls_international { false }
    net_international { false }
  end
end
