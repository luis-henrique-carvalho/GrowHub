# frozen_string_literal: true

# == Schema Information
#
# Table name: client_bookings
#
#  id                     :uuid             not null, primary key
#  cancellation_reason    :text
#  notes                  :text
#  status                 :integer          default("pending"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  client_profile_id      :uuid             not null
#  mentor_availability_id :uuid             not null
#  session_id             :uuid
#
# Indexes
#
#  index_client_bookings_on_client_profile_id                  (client_profile_id)
#  index_client_bookings_on_mentor_availability_id             (mentor_availability_id)
#  index_client_bookings_on_mentor_availability_id_and_status  (mentor_availability_id) UNIQUE WHERE (status = 1)
#  index_client_bookings_on_session_id                         (session_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_profile_id => client_profiles.id)
#  fk_rails_...  (mentor_availability_id => mentor_availabilities.id)
#  fk_rails_...  (session_id => sessions.id)
#
module Client
  class Booking < ApplicationRecord
    belongs_to :client_profile, class_name: 'Client::Profile'
    belongs_to :mentor_availability, class_name: 'Mentor::Availability'

    belongs_to :session, optional: true

    enum :status, {
      pending: 0,
      confirmed: 1,
      cancelled_by_client: 2,
      cancelled_by_mentor: 3,
      rejected: 4
    }

    validates :status, presence: true
    validate :availability_must_be_available_for_confirmation, if: :will_be_confirmed?

    scope :cancelled, -> { where(status: %i[cancelled_by_client cancelled_by_mentor]) }

    private

    def will_be_confirmed?
      status_changed?(to: 'confirmed') || (persisted? && confirmed?)
    end

    def availability_must_be_available_for_confirmation
      return if mentor_availability_id.blank?

      is_already_booked = Client::Booking
                          .where(mentor_availability_id: mentor_availability_id)
                          .confirmed
                          .where.not(id: id)
                          .exists?

      return unless is_already_booked

      # TODO: I18n
      errors.add(:mentor_availability_id, :already_confirmed,
                 message: 'Este horário já possui um agendamento confirmado.')
    end
  end
end
