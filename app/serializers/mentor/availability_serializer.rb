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
module Mentor
  class AvailabilitySerializer < ApplicationSerializer
    identifier :id

    fields :id, :start_time, :end_time

    field :duration_in_minutes, &:duration_in_minutes

    field :available, &:available?

    view :private do
      association :mentor_profile, blueprint: Mentor::ProfileSerializer
    end

    view :full do
      include_view :private

      association :bookings, blueprint: ::Client::BookingSerializer
    end
  end
end
