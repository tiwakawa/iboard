# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    title { Forgery::Basic.text(:at_most => 10) }
    user  { FactoryGirl.create(:user) }
  end
end
