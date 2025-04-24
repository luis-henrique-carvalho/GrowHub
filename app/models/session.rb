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
class Session < ApplicationRecord
  belongs_to :mentor_profile, class_name: 'Mentor::Profile'
  belongs_to :client_profile, class_name: 'Client::Profile'

  has_one :client_booking, class_name: 'Client::Booking', inverse_of: :session

  enum :status, {
    pending: 0,
    completed: 1,
    cancelled: 2
  }
end
