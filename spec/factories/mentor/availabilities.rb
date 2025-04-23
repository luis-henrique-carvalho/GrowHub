# frozen_string_literal: true

# == Schema Information
#
# Table name: mentor_availabilities
#
#  id                :uuid             not null, primary key
#  booked            :boolean
#  end_time          :datetime
#  start_time        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  mentor_profile_id :uuid             not null
#
# Indexes
#
#  index_mentor_availabilities_on_mentor_profile_id  (mentor_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (mentor_profile_id => mentor_profiles.id)
#
FactoryBot.define do
  factory :mentor_availability, class: 'Mentor::Availability' do
    mentor_profile { association(:mentor_profile) }
    start_time { Faker::Time.forward(days: 30, period: :morning) }
    end_time { Faker::Time.forward(days: 30, period: :afternoon) }
    booked { false }
  end
end
