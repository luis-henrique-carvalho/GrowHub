# frozen_string_literal: true

#
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
class SessionSerializer < ApplicationSerializer
  identifier :id

  fields :meeting_url, :status

  view :private do
    association :mentor_profile, blueprint: Mentor::ProfileSerializer
    association :client_profile, blueprint: Client::ProfileSerializer
    association :client_booking, blueprint: Client::BookingSerializer
  end
end
