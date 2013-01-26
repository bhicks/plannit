FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "example#{n}@example#{n + 1}.com"
    end
    password 'pleasehammerdonthurtem'
    password_confirmation { |u| u.password }
    confirmed_at Time.now

    trait :missing_email do
      email ''
    end

    trait :duplicate do
      email 'duplicate@duplicate.com'
    end

    trait :case_insensitive_duplicate do
      email 'DUPLICATE@DUPLICATE.COM'
    end

    trait :valid_email_1 do
      email 'user@foo.com'
    end

    trait :valid_email_2 do
      email 'THE_USER@foo.bar.org'
    end

    trait :valid_email_3 do
      email 'first.last@foo.jp'
    end

    trait :invalid_email_1 do
      email 'user@foo,com'
    end

    trait :invalid_email_2 do
      email 'user_at_foo.org'
    end

    trait :invalid_email_3 do
      email 'example.user@foo.'
    end

    trait :invalid_password do
      password ''
      password_confirmation ''
    end

    trait :nonmatching_password_confirmation do
      password_confirmation 'invalid'
    end

    trait :short_password do
      password 'short'
      password_confirmation { |u| u.password }
    end
  end
end
