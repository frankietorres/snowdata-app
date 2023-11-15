class SnotelWeatherObservation < ApplicationRecord
  belongs_to :snotel_weather_station, foreign_key: 'snotel_weather_station_id', primary_key: 'name'
end
