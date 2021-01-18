module SupplierDataNormalizer
  class Base
    def perform(supplier)
      hotel_list.map { |hotel| normalize(hotel) }
    rescue StandardError => e
      Rails.logger.info "Something went wrong while normalizing list of supplier with id #{supplier.id}"
      Rails.logger.info e
    end

    private

    def normalize(hotel)
      normalized_hotel = {}
      supplier_code(hotel, normalized_hotel)
      name(hotel, normalized_hotel)
      description(hotel, normalized_hotel)
      destination_id(hotel, normalized_hotel)
      location(hotel, normalized_hotel)
      amenities(hotel, normalized_hotel)
      images(hotel, normalized_hotel)
      booking_conditions(hotel, normalized_hotel)
      normalized_hotel
    end

    def hotel_list
      resp = Net::HTTP.get_response(URI.parse(source))
      data = resp.body
      JSON.parse(data)
    end

    def downcase_list_elements(list)
      list&.map { |f| f.strip.downcase } || []
    end

    def source; end

    def supplier_code(hotel, normalized_hotel); end

    def name(hotel, normalized_hotel); end

    def description(hotel, normalized_hotel); end

    def destination_id(hotel, normalized_hotel); end

    def location(hotel, normalized_hotel); end

    def amenities(hotel, normalized_hotel); end

    def images(hotel, normalized_hotel); end

    def booking_conditions(hotel, normalized_hotel); end
  end
end
