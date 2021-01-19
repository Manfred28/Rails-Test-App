class RenameHotelAmenitiesColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :hotels, :amenities, :denorm_amenities
  end
end
