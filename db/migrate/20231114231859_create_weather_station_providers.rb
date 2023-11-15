class CreateWeatherStationProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :weather_station_providers do |t|
      t.string :name

      t.timestamps
    end
  end
end
