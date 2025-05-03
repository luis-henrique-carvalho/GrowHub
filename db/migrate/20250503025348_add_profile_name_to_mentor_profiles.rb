class AddProfileNameToMentorProfiles < ActiveRecord::Migration[8.0]
  def change
    add_column :mentor_profiles, :profile_name, :string
    add_index :mentor_profiles, :profile_name
  end
end
