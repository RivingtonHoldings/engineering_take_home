class CreateEnumCustomFields < ActiveRecord::Migration[7.2]
  def change
    create_table :enum_custom_fields do |t|
      t.references :client
      t.string :name, null: false
      t.string :values, array: true, default: []
      t.date :effective
      t.date :deleted_at

      t.timestamps
    end
  end
end
