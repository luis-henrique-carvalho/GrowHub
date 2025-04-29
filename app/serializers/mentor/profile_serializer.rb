# frozen_string_literal: true

module Mentor
  class ProfileSerializer < ApplicationSerializer
    identifier :id

    fields :bio, :headline, :hourly_rate, :linkedin_url, :rating, :years_of_experience

    association :expertise_areas, blueprint: ExpertiseAreaSerializer
    association :availabilities, blueprint: AvailabilitySerializer

    view :private do
      association :sessions, blueprint: SessionSerializer
      association :client_profiles, blueprint: ClientProfileSerializer
    end
  end
end
