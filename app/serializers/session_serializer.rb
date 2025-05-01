# frozen_string_literal: true

class SessionSerializer < ApplicationSerializer
  identifier :id

  fields :meeting_url, :status

  view :private do
    association :mentor_profile, blueprint: Mentor::ProfileSerializer
    association :client_profile, blueprint: Client::ProfileSerializer

    association :client_booking, blueprint: Client::BookingSerializer
  end
end
