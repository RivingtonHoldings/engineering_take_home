class CreateBuildings < ActiveRecord::Migration[7.2]
  def change
    create_table :buildings do |t|
      t.references :client
      t.string :street_address_one, null: false
      t.string :street_address_two
      t.string :city, null: false
      t.string :state, null: false
      t.string :zipcode, null: false
      t.jsonb :custom_fields

      t.timestamps
    end
  end
end
