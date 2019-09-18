FactoryBot.define do
  factory :bank_contract do
    supplier { "MyString" }
    group_name { "MyString" }
    accountings_fees { 1.5 }
    cheque { false }
    price_cheque { 1.5 }
    price_order_cheque { 1.5 }
    insurance_paiment { 1.5 }
    sms_alert { 1.5 }
    international_withdraw { 1.5 }
  end
end
