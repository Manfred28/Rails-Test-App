class AddDefaultValuesToHotel < ActiveRecord::Migration[6.0]
  def change
    change_column_default :hotels, :location, {}
    change_column_default :hotels, :amenities, {}
    change_column_default :hotels, :images, {}
    change_column_default :hotels, :booking_conditions, []
  end
end
