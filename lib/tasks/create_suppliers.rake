desc 'create suppliers that have a data normalizer set up'
task create_suppliers: :environment do
  %w[Acme Paperflies Patagonia].each do |supplier_name|
    Supplier.find_or_create_by(name: supplier_name)
  end
end
