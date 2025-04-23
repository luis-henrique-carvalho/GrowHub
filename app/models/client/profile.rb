# frozen_string_literal: true

module Client
  class Profile < ApplicationRecord
    belongs_to :user
    has_many :bookings, class_name: 'Client::Booking', dependent: :destroy
    has_many :sessions, dependent: :destroy

    enum :career_stage, {
      student: 0,
      entry_level: 1,
      mid_level: 2,
      senior: 3,
      career_transition: 4
    }

    validates :career_stage, presence: true
  end
end
