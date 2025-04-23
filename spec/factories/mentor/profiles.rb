# frozen_string_literal: true

FactoryBot.define do
  factory :mentor_profile, class: 'Mentor::Profile' do
    user { association :user }
    bio { Faker::Lorem.paragraph }
    headline { Faker::Job.title }
    hourly_rate { Faker::Number.decimal(l_digits: 2) }
    linkedin_url { Faker::Internet.url(host: 'linkedin.com') }
    rating { Faker::Number.decimal(l_digits: 1) }
    years_of_experience { Faker::Number.between(from: 1, to: 20) }

    trait :with_expertise_areas do
      transient do
        expertise_areas_count { 3 }
      end

      after(:create) do |mentor_profile, evaluator|
        create_list(:mentor_expertise_assignment, evaluator.expertise_areas_count, mentor_profile: mentor_profile)
      end
    end
  end
end
