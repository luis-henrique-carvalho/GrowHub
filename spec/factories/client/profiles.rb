# frozen_string_literal: true

FactoryBot.define do
  factory :client_profile, class: 'Client::Profile' do
    user { nil }
    full_name { 'MyString' }
    career_stage { 0 }
    bio { 'MyText' }
    linkedin_url { 'MyString' }
  end
end
