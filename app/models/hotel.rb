class Hotel < ApplicationRecord
  has_many :hotel_suppliers
  has_many :suppliers, through: :hotel_suppliers
  has_many :hotel_amenities
  has_many :amenities, through: :hotel_amenities
end
