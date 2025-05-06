# frozen_string_literal: true

# == Schema Information
#
# Table name: mentor_profiles
#
#  id                  :uuid             not null, primary key
#  bio                 :text
#  headline            :string
#  hourly_rate         :decimal(, )
#  linkedin_url        :string
#  TODO: Add not null in profile_name
#  profile_name        :string
#  rating              :float
#  years_of_experience :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :uuid             not null
#
# Indexes
#
#  index_mentor_profiles_on_profile_name  (profile_name)
#  index_mentor_profiles_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
module Mentor
  class Profile < ApplicationRecord
    belongs_to :user

    has_many :expertise_assignments, class_name: 'Mentor::ExpertiseAssignment', dependent: :destroy,
                                     foreign_key: :mentor_profile_id, inverse_of: :mentor_profile
    has_many :expertise_areas, through: :expertise_assignments, source: :mentor_expertise_area,
                               class_name: 'Mentor::ExpertiseArea'

    has_many :availabilities, class_name: 'Mentor::Availability', dependent: :destroy, foreign_key: :mentor_profile_id,
                              inverse_of: :mentor_profile

    has_many :sessions, class_name: 'Session', foreign_key: :mentor_profile_id,
                        inverse_of: :mentor_profile, dependent: :destroy
    has_many :client_profiles, through: :sessions, source: :client_profile, class_name: 'Client::Profile'
  end
end
