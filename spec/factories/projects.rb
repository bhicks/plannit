FactoryGirl.define do
  factory :project do
    deadline { (DateTime.now + 7).to_time }
    user
    sequence :description do
      |n| "My Description #{n}"
    end

    trait :no_description do
      description ''
    end

    trait :no_user do
      user nil
    end

    trait :no_deadline do
      deadline nil
    end

    trait :bad_date do
      deadline "notadate"
    end
  end
end
