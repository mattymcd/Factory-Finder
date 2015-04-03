require 'csv'

CSV.foreach("/home/mbm7a/Documents/DBC/Factory-Finder/db/seed.csv", :headers => true) do | row |
	hash = row.to_h
	Shipment.create(hash)
  
end

Shipment.all.each do | shipment |
    downcase_item = shipment.item.downcase
    shipment.update_attributes(:item => downcase_item)
end
# downcasing the item column in the database in order to search it