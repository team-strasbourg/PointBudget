FactoryBot.define do
  factory :gaz_contract do
    supplier { 'MyString' }
    offer_name { 'MyString' }
    kw_consumption_per_year { [1, 6, 30].sample }
    subscription_base_price_month { rand(6.00..40.00) }
    kwh_price_base { rand(0.04000..0.10000) }
    factory :gas_contract_less_year_consumption do
      kw_consumption_per_year { 0 }
    end
    factory :gas_contract_more_year_consumption do
      kw_consumption_per_year { 31 }
    end
  end

end
