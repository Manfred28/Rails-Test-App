module SupplierDataNormalizer
  class Patagonia < Base
    private

    def source
      'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia'
    end

    def supplier_code(hotel, normalized_hotel)
      normalized_hotel[:supplier_code] = hotel['id']&.strip
    end

    def name(hotel, normalized_hotel)
      normalized_hotel[:name] = hotel['name']&.strip
    end

    def description(hotel, normalized_hotel)
      normalized_hotel[:description] = hotel['info']&.strip
    end

    def destination_id(hotel, normalized_hotel)
      normalized_hotel[:destination_id] = hotel['destination']
    end

    def location(hotel, normalized_hotel)
      normalized_hotel[:location] = {
        lat: hotel['lat'],
        lng: hotel['lng'],
        address: hotel['address']&.strip
      }
    end

    def amenities(hotel, normalized_hotel)
      normalized_hotel[:amenities] = {
        other: downcase_list_elements(hotel['amenities'])
      }
    end

    def images(hotel, normalized_hotel)
      normalized_hotel[:images] = {
        rooms: hotel['images']&.[]('rooms') || [],
        amenities: hotel['images']&.[]('amenities') || []
      }
    end

    def booking_conditions(_hotel, normalized_hotel)
      normalized_hotel[:booking_conditions] = []
    end
  end
end
