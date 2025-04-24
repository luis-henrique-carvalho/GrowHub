class CreateClientBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :client_bookings, id: :uuid do |t|
     t.references :client_profile, null: false, foreign_key: true, index: true, type: :uuid
     t.references :mentor_availability, null: false, foreign_key: true, index: true, type: :uuid

     t.references :session, foreign_key: true, index: true, type: :uuid

     t.integer :status, null: false, default: 0
     t.text :notes
     t.text :cancellation_reason

     t.timestamps
   end

   add_index :client_bookings, :mentor_availability_id, unique: true, where: "status = 1", name: "index_client_bookings_on_mentor_availability_id_and_status"
  end
end
