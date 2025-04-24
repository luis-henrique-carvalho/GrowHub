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

    scope :available, -> { where(booked: [false, nil]) }
    scope :upcoming, -> { where('mentor_availabilities.start_time > ?', Time.current) }
    scope :within_range, lambda { |start_range, end_range|
      where(
        'mentor_availabilities.start_time < :end_range AND mentor_availabilities.end_time > :start_range',
        start_range: start_range, end_range: end_range
      )
    }
    scope :for_mentor, ->(mentor_profile) { where(mentor_profile: mentor_profile) }

    def duration_in_minutes
      return 0 unless start_time && end_time

      ((end_time - start_time) / 60).to_i
    end

    private

    def end_time_must_be_after_start_time
      return if start_time.blank? || end_time.blank?

      return unless end_time <= start_time

      errors.add(:end_time, :must_be_after_start_time,
                 message: 'deve ser posterior ao horário de início') # TODO: I18n
    end

    def prevent_overlapping_availabilities
      return if start_time.blank? || end_time.blank? || mentor_profile_id.blank?

      overlapping_slots = Availability
                          .where(mentor_profile_id: mentor_profile_id)
                          .where.not(id: id)
                          .where(
                            'start_time < :end_time AND end_time > :start_time',
                            start_time: start_time, end_time: end_time
                          )

      return unless overlapping_slots.exists?

      errors.add(:base, :overlapping_availability,
                 message: 'Já existe um horário de disponibilidade conflitante para este mentor.') # TODO: I18n
    end
  end
end
