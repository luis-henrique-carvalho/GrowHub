class RenameFullNameToProfileNameInClientProfiles < ActiveRecord::Migration[8.0]
  def change
    rename_column :client_profiles, :full_name, :profile_name
    add_index :client_profiles, :profile_name
  end
end
