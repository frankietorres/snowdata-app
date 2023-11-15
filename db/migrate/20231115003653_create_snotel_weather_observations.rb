class CreateSnotelWeatherObservations < ActiveRecord::Migration[7.0]
  def change
    create_table :snotel_weather_observations do |t|
      t.date :date
      t.time :time
      t.float :temp
      t.float :max_temp
      t.float :min_temp
      t.float :wind_speed
      t.integer :wind_direction
      t.float :wind_gust_speed
      t.float :melted_precipitation_1hr
      t.float :snow_height
      t.float :snow_water_equivalent
      t.references :snotel_weather_station, null: false, foreign_key: true

      t.timestamps
    end
  end
end
