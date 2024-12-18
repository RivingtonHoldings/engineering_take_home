class CreateInputCustomFields < ActiveRecord::Migration[7.2]
  def change
    create_table :input_custom_fields do |t|
      t.references :client
      t.string :name, null: false
      t.integer :input_type, null: false
      t.date :effective
      t.date :deleted_at

      t.timestamps
    end
  end
end
