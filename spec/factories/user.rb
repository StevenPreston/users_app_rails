FactoryGirl.define do
  factory :user do
    email Faker::Internet.free_email
    password 'password'
    password_confirmation 'password'

    factory :user_with_places do
      transient do
        places_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:place, evaluator.places_count, user: user)
      end
    end
  end
end
