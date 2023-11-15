class CreateSnotelWeatherStations < ActiveRecord::Migration[7.0]
  def change
    create_table :snotel_weather_stations do |t|
      t.string :name
      t.float :elevation

      t.timestamps
    end
  end
end
