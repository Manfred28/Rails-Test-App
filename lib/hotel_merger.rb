class HotelMerger
  def initialize(hotel_data, supplier)
    @hotel_data = hotel_data
    @supplier = supplier
  end

  def merge
    supplier
    name
    location
    description
    amenities
    images
    booking_conditions
    hotel_record.save!
  end

  private

  def hotel_record
    @hotel_record ||= Hotel.find_or_create_by(
      supplier_code: @hotel_data[:supplier_code], destination_id: @hotel_data[:destination_id]
    )
  end

  def supplier
    HotelSupplier.find_or_create_by!(hotel: hotel_record, supplier: @supplier)
  end

  def name
    return unless (hotel_record.name&.length || 0) < @hotel_data[:name]&.length

    hotel_record.name = @hotel_data[:name]
  end

  def location
    latitude
    longitude
    country
    city
    address
  end

  def latitude
    return unless @hotel_data[:location][:lat] && hotel_record.location['lat'].blank?

    hotel_record.location[:lat] = @hotel_data[:location][:lat]
  end

  def longitude
    return unless @hotel_data[:location][:lng] && hotel_record.location['lng'].blank?

    hotel_record.location[:lng] = @hotel_data[:location][:lng]
  end

  def country
    return unless @hotel_data[:location][:country] && hotel_record.location['country'].blank?

    hotel_record.location[:country] = @hotel_data[:location][:country]
  end

  def city
    return unless @hotel_data[:location][:city] && hotel_record.location['city'].blank?

    hotel_record.location[:city] = @hotel_data[:location][:city]
  end

  def address
    return unless @hotel_data[:location][:address]
    return unless @hotel_data[:location][:address].length > (hotel_record.location['address']&.length || 0)

    hotel_record.location[:address] = @hotel_data[:location][:address]
  end

  def description
    return unless @hotel_data[:description] && hotel_record.description.blank?

    hotel_record.description = @hotel_data[:description]
  end

  def amenities
    @hotel_data[:amenities]&.[](:general)&.each do |amenity_name|
      amenity = Amenity.find_or_create_by!(name: amenity_name, classification: 'general')
      HotelAmenity.find_or_create_by(hotel: hotel_record, amenity: amenity)
    end
    @hotel_data[:amenities]&.[](:room)&.each do |amenity_name|
      amenity = Amenity.find_or_create_by!(name: amenity_name, classification: 'room')
      HotelAmenity.find_or_create_by(hotel: hotel_record, amenity: amenity)
    end
    @hotel_data[:amenities]&.[](:other)&.each do |amenity_name|
      next if hotel_record.amenities.find_by(name: amenity_name, classification: %w[general room])

      amenity = Amenity.find_or_create_by!(name: amenity_name, classification: 'other')
      HotelAmenity.find_or_create_by(hotel: hotel_record, amenity: amenity)
    end
  end

  def images
    @hotel_data[:images]&.[](:rooms)&.each do |image|
      next if hotel_record.images['rooms']
        &.find { |record_image| record_image['link'] == image[:link] }

      hotel_record.images['rooms'] ||= []
      hotel_record.images['rooms'].push(image)
      hotel_record.images
    end
    @hotel_data[:images]&.[](:site)&.each do |image|
      next if hotel_record.images['site']
        &.find { |record_image| record_image['link'] == image[:link] }

      hotel_record.images['site'] ||= []
      hotel_record.images['site'].push(image)
    end
    @hotel_data[:images]&.[](:amenities)&.each do |image|
      next if hotel_record.images['amenities']
        &.find { |record_image| record_image['link'] == image[:link] }

      hotel_record.images['amenities'] ||= []
      hotel_record.images['amenities'].push(image)
    end
  end

  def booking_conditions
    @hotel_data[:booking_conditions].each do |condition|
      next unless hotel_record.booking_conditions.include?(condition)

      hotel_record.booking_conditions.push(condition)
    end
  end
end
