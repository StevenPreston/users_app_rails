class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.text :name
      t.integer :utc_offset
      t.decimal :longitude, precision: 10, scale: 6
      t.decimal :latitiude, precision: 10, scale: 6
      t.text :formatted_address
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
