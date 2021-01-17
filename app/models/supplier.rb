class Supplier < ApplicationRecord
  has_many :hotel_suppliers
  has_many :hotels, through: :hotel_suppliers
end
