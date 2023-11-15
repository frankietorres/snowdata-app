class SnotelWeatherStation < ApplicationRecord
    self.primary_key = 'name'
    has_many :snotel_weather_observations, foreign_key: 'snotel_weather_station_id', primary_key: 'name'
end
