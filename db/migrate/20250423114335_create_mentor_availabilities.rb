class CreateMentorAvailabilities < ActiveRecord::Migration[8.0]
  def change
    create_table :mentor_availabilities, id: :uuid do |t|
      t.references :mentor_profile, null: false, foreign_key: true, type: :uuid
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :booked

      t.timestamps
    end
  end
end
