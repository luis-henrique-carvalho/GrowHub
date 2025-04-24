# frozen_string_literal: true

# == Schema Information
#
# Table name: sessions
#
#  id                :uuid             not null, primary key
#  duration_minutes  :integer
#  meeting_url       :string
#  scheduled_at      :datetime
#  status            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  client_profile_id :uuid             not null
#  mentor_profile_id :uuid             not null
#
# Indexes
#
#  index_sessions_on_client_profile_id  (client_profile_id)
#  index_sessions_on_mentor_profile_id  (mentor_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_profile_id => client_profiles.id)
#  fk_rails_...  (mentor_profile_id => mentor_profiles.id)
#
FactoryBot.define do
  factory :session do
    mentor_profile { association :mentor_profile }
    client_profile { association :client_profile }

    scheduled_at { Faker::Time.forward(days: 365, period: :morning) }
    duration_minutes { Faker::Number.between(from: 30, to: 120) }
    meeting_url { Faker::Internet.url }
    status { Faker::Number.between(from: 0, to: 2) }
  end
end
