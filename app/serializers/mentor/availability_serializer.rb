# frozen_string_literal: true

module Mentor
  class AvailabilitySerializer < ApplicationSerializer
    identifier :id

    fields :id, :start_time, :end_time

    attribute :duration_in_minutes do
      object.duration_in_minutes
    end

    attribute :available do
      object.available?
    end

    view :private do
      associations :mentor_profile, blueprint: Mentor::ProfileSerializer
    end

    view :full do
      include_view :private

      associations :bookings, blueprint: Client::BookingSerializer
    end
  end
end
