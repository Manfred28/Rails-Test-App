class HotelAmenity < ApplicationRecord
  belongs_to :hotel
  belongs_to :amenity

  after_create :destroy_duplicate_other_amenity
  after_save :insert_into_hotel_denorm_amenities

  def insert_into_hotel_denorm_amenities
    return if hotel.denorm_amenities[amenity.classification]&.include?(amenity.name)

    hotel.denorm_amenities[amenity.classification] ||= []
    hotel.denorm_amenities[amenity.classification] << amenity.name
    hotel.update_column(:denorm_amenities, hotel.denorm_amenities)
  end


  def destroy_duplicate_other_amenity
    return if amenity.classification == 'other' ||
    !(other_amenity = hotel.amenities.find_by(name: amenity.name, classification: 'other'))

    other_amenity.destroy!
    remove_from_hotel_denorm_amenities
  end

  def remove_from_hotel_denorm_amenities
    hotel.denorm_amenities['other'].delete(amenity.name)
    hotel.update_column(:denorm_amenities, hotel.denorm_amenities)
  end
end
