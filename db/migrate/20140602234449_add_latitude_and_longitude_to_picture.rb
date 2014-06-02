class AddLatitudeAndLongitudeToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :latitude, :float
    add_column :pictures, :longitude, :float
  end
end
