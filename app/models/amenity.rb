class Amenity < ApplicationRecord
  has_many :hotel_amenities
  has_many :hotels, through: :hotel_amenities
end
