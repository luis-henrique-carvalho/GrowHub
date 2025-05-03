# frozen_string_literal: true

module Mentor
  class AvailabilitySerializer < ApplicationSerializer
    identifier :id

    fields :id, :start_time, :end_time

    field :duration_in_minutes, &:duration_in_minutes

    field :available, &:available?

    view :private do
      association :mentor_profile, blueprint: Mentor::ProfileSerializer
    end

    view :full do
      include_view :private

      association :bookings, blueprint: ::Client::BookingSerializer
    end
  end
end
