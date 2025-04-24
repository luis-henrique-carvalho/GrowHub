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
  class Availability < ApplicationRecord
    belongs_to :mentor_profile, class_name: 'Mentor::Profile',
                                inverse_of: :availabilities

    has_many :bookings, class_name: 'Client::Booking', foreign_key: :mentor_availability_id,
                        inverse_of: :mentor_availability, dependent: :restrict_with_error

    validates :start_time, :end_time, presence: true
    validate :end_time_must_be_after_start_time

    scope :available, -> { where(booked: false) }
  end
end
