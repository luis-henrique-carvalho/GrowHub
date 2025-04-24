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
FactoryBot.define do
  factory :client_booking, class: 'Client::Booking' do
    client_profile { association(:client_profile) }
    mentor_availability { association(:mentor_availability) }
    session { association(:session) }
    status { :pending }
    notes { Faker::Lorem.paragraph }
    cancellation_reason { Faker::Lorem.sentence }
  end
end
