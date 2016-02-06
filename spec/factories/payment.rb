FactoryGirl.define do
  factory :payment do
    credit_card_number { Faker::Business.credit_card_number }
    cardholder_name    { Faker::Name.name }
    expiration_month    '08'
    expiration_year     '20'
    card_security_code  '111'
    amount              20000
    card_network        'visa'
    card_last_numbers   '1111'
  end

end
