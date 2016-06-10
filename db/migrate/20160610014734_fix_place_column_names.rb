class FixPlaceColumnNames < ActiveRecord::Migration[5.0]
  def change
    rename_column :places, :latitiude, :lat
    rename_column :places, :longitude, :lng
    change_column :places, :name, :text, null: false
  end
end
