module SupplierDataNormalizer
  class Paperflies < Base
    private

    def source
      'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies'
    end

    def supplier_code(hotel, normalized_hotel)
      normalized_hotel[:supplier_code] = hotel['hotel_id']&.strip
    end

    def name(hotel, normalized_hotel)
      normalized_hotel[:name] = hotel['hotel_name']&.strip
    end

    def description(hotel, normalized_hotel)
      normalized_hotel[:description] = hotel['details']&.strip
    end

    def destination_id(hotel, normalized_hotel)
      normalized_hotel[:destination_id] = hotel['destination_id']
    end

    def location(hotel, normalized_hotel)
      normalized_hotel[:location] = {
        address: hotel['location']&.[]('address')&.strip,
        country: hotel['location']&.[]('country')&.strip
      }
    end

    def amenities(hotel, normalized_hotel)
      normalized_hotel[:amenities] = {
        general: hotel['amenities']&.[]('general')&.map { |f| f.strip.downcase },
        room: hotel['amenities']&.[]('room')&.map { |f| f.strip.downcase }
      }
    end

    def images(hotel, normalized_hotel)
      normalized_hotel[:images] = {
        rooms: hotel['images']&.[]('rooms')
          &.map { |image| return { image: image['link']}, descripion: image['caption'] },
        site: hotel['images']&.[]('site')
          &.map { |image| return { image: image['link']}, descripion: image['caption'] }
      }
    end

    def booking_conditions(hotel, normalized_hotel)
      normalized_hotel[:booking_conditions] = hotel['booking_conditions']&.map{ |f| f.strip.downcase }
    end
  end
end
