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
  class ProfileSerializer < ApplicationSerializer
    identifier :id

    fields :bio, :career_stage, :profile_name, :linkedin_url

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
