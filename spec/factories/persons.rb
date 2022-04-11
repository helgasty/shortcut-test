FactoryBot.define do
  factory :person do
    reference { rand(1..10) }
    firstname  { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    home_phone_number { FFaker::PhoneNumberFR.phone_number }
    mobile_phone_number { FFaker::PhoneNumberFR.phone_number }
    email { FFaker::Internet.email }
    address { FFaker::AddressFR.full_address }
  end
end