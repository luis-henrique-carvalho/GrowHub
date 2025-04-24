class CreateSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions, id: :uuid do |t|
      t.references :mentor_profile, null: false, foreign_key: true, type: :uuid
      t.references :client_profile, null: false, foreign_key: true, type: :uuid
      t.datetime :scheduled_at
      t.integer :duration_minutes
      t.string :meeting_url
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
