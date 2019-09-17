FactoryBot.define do
  factory :box_contract do
    supplier { "MyString" }
    offer_name { "MyString" }
    price_month { 1.5 }
    commitment { 1 }
    price_after { 1.5 }
    type { "" }
    downstream { 1 }
    upstream { 1 }
    tv_channel { "MyString" }
    tv { false }
    call_fix_fr { false }
    call_mobile_fr { false }
    call_foreign { false }
    opening_fee { 1.5 }
    termination_fee { 1.5 }
    taken_termination { 1.5 }
  end
end
