class CreateMentorExpertiseAreas < ActiveRecord::Migration[8.0]
  def change
    create_table :mentor_expertise_areas, id: :uuid do |t|
      t.string :name

      t.timestamps
    end

    add_index :mentor_expertise_areas, :name, unique: true
  end
end
