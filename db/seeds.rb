# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Constants for generating random weather data
TEMP_RANGE = (20..40) # Temperature range in degrees
WIND_SPEED_RANGE = (5..20) # Wind speed range in mph
WIND_DIRECTION_RANGE = (0..360) # Wind direction range in degrees
PRECIPITATION_RANGE = (0.0..1.0) # Precipitation range in inches
SNOW_HEIGHT_RANGE = (0..30) # Snow height range in inches
SNOW_WATER_EQUIVALENT_RANGE = (0.0..10.0) # Snow water equivalent range in inches

# Helper method to generate random weather data
def random_weather_data
  {
    temp: rand(TEMP_RANGE),
    max_temp: rand(TEMP_RANGE),
    min_temp: rand(TEMP_RANGE),
    wind_speed: rand(WIND_SPEED_RANGE),
    wind_direction: rand(WIND_DIRECTION_RANGE),
    wind_gust_speed: rand(WIND_SPEED_RANGE),
    melted_precipitation_1hr: rand(PRECIPITATION_RANGE),
    snow_height: rand(SNOW_HEIGHT_RANGE),
    snow_water_equivalent: rand(SNOW_WATER_EQUIVALENT_RANGE)
  }
end

# Create test weather stations
weather_station1 = SnotelWeatherStation.find_or_create_by(name: "test-station1", elevation: 500)
weather_station2 = SnotelWeatherStation.find_or_create_by(name: "test-station2", elevation: 1000)

# Generate observations for 30 days, each day has 24 observations (hourly)
(1..30).each do |day|
  (0..23).each do |hour|
    [weather_station1, weather_station2].each do |station|
      observation_time = Time.now.midnight + (day-1).days + hour.hours
      weather_data = random_weather_data.merge(date: observation_time.to_date, time: observation_time)
      station.snotel_weather_observations.create!(weather_data)
    end
  end
end

puts "Generated weather observations for 30 days."