# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider     "twitter"
    uid          { Forgery::Basic.text(:at_most => 10) }
    name         { Forgery::Basic.text(:at_most => 10) }
    display_name { Forgery::Basic.text(:at_most => 10) }
  end
end
