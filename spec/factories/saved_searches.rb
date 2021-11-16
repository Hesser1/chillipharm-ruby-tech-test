# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :saved_searches do
    name "foo"
    keyword "boo"
    sort "created_at_desc"
    filter "all"

    association :library
  end
end
