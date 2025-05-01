# frozen_string_literal: true

module Client
  class BookingSerializer < ApplicationSerializer
    identifier :id

    fields :notes, :status, :notes

    view :private do
      association :mentor_profile, blueprint: Mentor::ProfileSerializer
      association :mentor_availability, blueprint: Mentor::AvailabilitySerializer
      association :session, blueprint: SessionSerializer
    end
  end
end
