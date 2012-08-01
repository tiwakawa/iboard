# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body  { Forgery::Basic.text(:at_most => 10) }
    user  { FactoryGirl.create(:user) }
    topic { FactoryGirl.create(:topic) }
  end
end
