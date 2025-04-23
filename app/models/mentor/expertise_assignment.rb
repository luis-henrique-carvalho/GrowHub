# frozen_string_literal: true

# == Schema Information
#
# Table name: mentor_expertise_assignments
#
#  id                       :uuid             not null, primary key
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  mentor_expertise_area_id :uuid             not null
#  mentor_profile_id        :uuid             not null
#
# Indexes
#
#  index_mentor_expertise_assignments_on_mentor_expertise_area_id  (mentor_expertise_area_id)
#  index_mentor_expertise_assignments_on_mentor_profile_id         (mentor_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (mentor_expertise_area_id => mentor_expertise_areas.id)
#  fk_rails_...  (mentor_profile_id => mentor_profiles.id)
#
module Mentor
  class ExpertiseAssignment < ApplicationRecord
    belongs_to :profile, class_name: 'Mentor::Profile'
    belongs_to :expertise_area, class_name: 'Mentor::ExpertiseArea'
  end
end
