# frozen_string_literal: true

# == Schema Information
#
# Table name: mentor_expertise_areas
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_mentor_expertise_areas_on_name  (name) UNIQUE
#
module Mentor
  class ExpertiseArea < ApplicationRecord
    has_many :expertise_assignments, class_name: 'Mentor::ExpertiseAssignment', dependent: :destroy
    has_many :profiles, through: :expertise_assignments, class_name: 'Mentor::Profile'
    has_many :users, through: :profiles
  end
end
