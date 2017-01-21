FactoryGirl.define do
  factory :link do
    title { Faker::Lorem.sentence }
    url { Faker::Internet.url('example.com') }
    hostname "example.com"
    popularity { Faker::Number.decimal(2) }
  end
end