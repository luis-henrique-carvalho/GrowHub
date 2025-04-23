class CreateClientProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :client_profiles, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :full_name
      t.integer :career_stage, null: false, default: 0
      t.text :bio
      t.string :linkedin_url

      t.timestamps
    end
  end
end
