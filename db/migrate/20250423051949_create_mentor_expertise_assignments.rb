class CreateMentorExpertiseAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :mentor_expertise_assignments, id: :uuid do |t|
      t.references :mentor_profile, null: false, foreign_key: true, type: :uuid
      t.references :mentor_expertise_area, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
