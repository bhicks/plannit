FactoryGirl.define do
  factory :task do
    sequence :description do
      |n| "My Task #{n}"
    end
    deadline { (DateTime.now + 7).to_time }
    completed false
    project
  end

  trait :no_description do
    description nil
  end

  trait :no_project do
    project nil
  end

  trait :no_deadline do
    deadline nil
  end

  trait :bad_date do
    deadline 'notadate'
  end

  trait :no_completed_date do
    completed_datetime nil
  end

  trait :bad_completed_date do
    completed_datetime 'notadate'
  end

  trait :no_default_completed do
    completed nil
  end
end
