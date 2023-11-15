class SnotelWeatherStation < ApplicationRecord
    has_many :snotel_weather_observations
end
