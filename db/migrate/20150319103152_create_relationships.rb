class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :idol_id
      t.integer :fan_id
      t.timestamps
    end
  end
end
