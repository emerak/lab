FactoryGirl.define do
  factory :payment do
    credit_card_number { Faker::Business.credit_card_number }
    cardholder_name    { Faker::Name.name }
    expiration_date    '20/08'
    card_security_code '111'
  end

end
