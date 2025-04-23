# frozen_string_literal: true

# == Schema Information
#
# Table name: client_profiles
#
#  id           :uuid             not null, primary key
#  bio          :text
#  career_stage :integer          default("student"), not null
#  full_name    :string
#  linkedin_url :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :uuid             not null
#
# Indexes
#
#  index_client_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :client_profile, class: 'Client::Profile' do
    user { association :user }
    full_name { Faker::Name.name }
    career_stage { 0 }
    bio { Faker::Lorem.paragraph }
    linkedin_url { Faker::Internet.url(host: 'linkedin.com') }
  end
end
