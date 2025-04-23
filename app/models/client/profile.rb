# frozen_string_literal: true

# == Schema Information
#
# Table name: client_profiles
#
#  id           :uuid             not null, primary key
#  bio          :text
#  career_stage :integer          default("student"), not null
#  full_name    :string
#  linkedin_url :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :uuid             not null
#
# Indexes
#
#  index_client_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
