# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    deadline "2013-01-15 22:17:51"
    user_id 1
    description "MyString"
  end
end
