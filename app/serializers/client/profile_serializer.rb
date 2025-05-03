# frozen_string_literal: true

module Client
  class ProfileSerializer < ApplicationSerializer
    identifier :id

    fields :bio, :career_stage, :full_name, :linkedin_url

    view :private do
      association :user, blueprint: UserSerializer
    end

    view :full do
      association :sessions, blueprint: SessionSerializer
      association :bookings, blueprint: Client::BookingSerializer
      association :mentor_profiles, blueprint: Mentor::ProfileSerializer
    end
  end
end
