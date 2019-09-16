FactoryBot.define do
  factory :electricity_contract do
    supplier { "MyString" }
    offer_name { "MyString" }
    subscription_base_price_month { 1.5 }
    kwh_price_base { 1.5 }
  end
end
