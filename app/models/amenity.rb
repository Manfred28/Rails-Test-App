class Amenity < ApplicationRecord
  has_many :hotel_amenities
  has_many :hotels, through: :hotel_amenities

  enum classification: {
    general: 10,
    room: 20,
    other: 30
  }
end
