FactoryBot.define do
  factory :building do
    reference { rand(1..10) }
    address  { FFaker::AddressFR.full_address }
    zip_code { FFaker::AddressFR.zip_code }
    country { FFaker::AddressFR.country }
    manager_name { FFaker::Name.name }
  end
end