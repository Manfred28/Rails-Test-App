class HotelSupplier < ApplicationRecord
  belongs_to :hotel
  belongs_to :supplier
end
