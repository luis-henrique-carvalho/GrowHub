# frozen_string_literal: true

# == Schema Information
#
# Table name: client_profiles
#
#  id           :uuid             not null, primary key
#  bio          :text
#  career_stage :integer          default("student"), not null
#  linkedin_url :string
#  profile_name :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :uuid             not null
#
# Indexes
#
#  index_client_profiles_on_profile_name  (profile_name)
#  index_client_profiles_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
module Client
  class Profile < ApplicationRecord
    belongs_to :user

    has_many :bookings, class_name: 'Client::Booking', dependent: :destroy, foreign_key: :client_profile_id,
                        inverse_of: :client_profile
    has_many :sessions, class_name: 'Session', foreign_key: :client_profile_id,
                        inverse_of: :client_profile, dependent: :destroy
    has_many :mentor_profiles, through: :sessions, source: :mentor_profile, class_name: 'Mentor::Profile'

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
