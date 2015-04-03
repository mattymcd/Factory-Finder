class CreateShipments < ActiveRecord::Migration
  def change
  	create_table :shipments do |t|
  		t.date :date
  		t.string :shipper
  		t.string :item
  		t.string :quantity
  		t.string :weight
  		t.string :consignee
  		t.timestamps
  	end
  end
end