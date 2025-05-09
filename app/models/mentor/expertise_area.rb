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
    include PgSearch::Model

    has_many :expertise_assignments, class_name: 'Mentor::ExpertiseAssignment', dependent: :destroy,
                                     foreign_key: :mentor_expertise_area_id, inverse_of: :mentor_expertise_area
    has_many :profiles, through: :expertise_assignments, class_name: 'Mentor::Profile'
    has_many :users, through: :profiles

    pg_search_scope :search, against: :name, using: {
      tsearch: { prefix: true }
    }
  end
end
