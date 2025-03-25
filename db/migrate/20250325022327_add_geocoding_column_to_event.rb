class AddGeocodingColumnToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :address, :string, null: false, default: ""
    add_column :events, :latitude, :float, null: false, default: 0
    add_column :events, :longitude, :float, null: false, default: 0
  end
end
