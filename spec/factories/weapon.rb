FactoryBot.define do
  factory :weapon do
    name { FFaker::Name.first_name }
    description { FFaker::Lorem.word }
    power_base { FFaker::Random.rand(1..3000) }
    power_step { FFaker::Random.rand(1..100) }
    level { 1 }
  end
end