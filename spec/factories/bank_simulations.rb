FactoryBot.define do
  factory :bank_simulation do
    bank_cost_saved { 1.5 }
    accounting_fees { 1.5 }
    inactive_accounting_fees { 1.5 }
    price_cheque { 1.5 }
    insurance_payment { 1.5 }
    sms_alert { 1.5 }
    international_withdraw { 1.5 }
  end
end
