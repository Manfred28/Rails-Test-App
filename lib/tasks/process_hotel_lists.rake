desc 'Download the available list of hotels, normalize the data and merge hotels'
task process_hotel_lists: :environment do
  Supplier.all.each do |supplier|
    normalizer = "SupplierDataNormalizer::#{supplier.name}".constantize.new
    hotel_list = normalizer.perform(supplier)
    hotel_list.each do |hotel|
      HotelMerger.new(hotel, supplier).merge
    rescue StandardError => e
      Rails.logger.info "Something went wrong while merging hotel #{hotel[:name]} from supplier #{supplier.id}"
      Rails.logger.info e
    end
  rescue StandardError => e
    Rails.logger.info "Something went wrong while processing list of supplier with id #{supplier.id}"
    Rails.logger.info e
  end
end
