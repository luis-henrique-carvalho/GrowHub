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
FactoryBot.define do
  factory :mentor_expertise_area, class: 'Mentor::ExpertiseArea' do
    name { 'MyString' }
  end
end
