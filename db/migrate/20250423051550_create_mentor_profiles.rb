class CreateMentorProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :mentor_profiles, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :headline
      t.text :bio
      t.string :linkedin_url
      t.integer :years_of_experience
      t.decimal :hourly_rate
      t.float :rating

      t.timestamps
    end
  end
end
