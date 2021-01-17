class CreateHotels < ActiveRecord::Migration[6.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :description
      t.integer :destination_id
      t.jsonb :location
      t.jsonb :amenities
      t.jsonb :images
      t.jsonb :booking_conditions

      t.timestamps
    end
  end
end
