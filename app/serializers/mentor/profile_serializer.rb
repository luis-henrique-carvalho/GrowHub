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
  class ProfileSerializer < ApplicationSerializer
    identifier :id

    fields :bio, :headline, :hourly_rate, :linkedin_url, :rating, :years_of_experience, :profile_name

    # Ensure hourly_rate is serialized as a float (not string)
    field :hourly_rate do |object|
      object.hourly_rate
    end

    association :expertise_areas, blueprint: Mentor::ExpertiseAreaSerializer
    association :availabilities, blueprint: Mentor::AvailabilitySerializer

    view :private do
      association :sessions, blueprint: SessionSerializer
      association :client_profiles, blueprint: Client::ProfileSerializer
    end
  end
end
