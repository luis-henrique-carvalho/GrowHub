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
    start_time { 1.day.from_now.beginning_of_hour }
    end_time { start_time.present? ? start_time + 1.hour : nil }
    booked { false }

    trait :in_past do
      start_time { 1.day.ago.beginning_of_hour }
      end_time { start_time.present? ? start_time + 1.hour : nil }
    end

    trait :booked do
      booked { true }
    end

    trait :long_duration do
      end_time { start_time.present? ? start_time + 3.hours : nil }
    end
  end
end
