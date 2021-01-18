module SupplierDataNormalizer
  class Acme < Base
    private

    def source
      'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme'
    end

    def supplier_code(hotel, normalized_hotel)
      normalized_hotel[:supplier_code] = hotel['Id']&.strip
    end

    def name(hotel, normalized_hotel)
      normalized_hotel[:name] = hotel['Name']&.strip
    end

    def description(hotel, normalized_hotel)
      normalized_hotel[:description] = hotel['Description']&.strip
    end

    def destination_id(hotel, normalized_hotel)
      normalized_hotel[:destination_id] = hotel['DestinationId']
    end

    def location(hotel, normalized_hotel)
      normalized_hotel[:location] = {
        lat: hotel['Latitude'],
        lng: hotel['Longitude'],
        address: "#{hotel['Address']&.strip}, #{hotel['PostalCode']&.strip}",
        city: hotel['City']&.strip,
        country: country_by_code(hotel['Country']&.strip)
      }
    end

    def amenities(hotel, normalized_hotel)
      normalized_hotel[:amenities] = {
        other: hotel['Facilities'].map { |f| f.strip.downcase }
      }
    end

    def images(_hotel, normalized_hotel)
      normalized_hotel[:images] = {}
    end

    def booking_conditions(_hotel, normalized_hotel)
      normalized_hotel[:booking_conditions] = []
    end

    def country_by_code(code)
      Rails.application.config_for(:country_codes)[code&.downcase&.to_sym] || code
    end
  end
end
