# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# Create a test weather station
weather_station = SnotelWeatherStation.create(name: "Test Station1", elevation: 500)
weather_station2 = SnotelWeatherStation.create(name: "Test Station2", elevation: 1000)

# Create some test weather observations associated with the test weather station
observation1 = weather_station.snotel_weather_observations.create!(
  date: Date.today,
  time: Time.now,
  temp: 32.5,
  max_temp: 35.0,
  min_temp: 30.0,
  wind_speed: 10.0,
  wind_direction: 180,
  wind_gust_speed: 15.0,
  melted_precipitation_1hr: 0.1,
  snow_height: 12.0,
  snow_water_equivalent: 5.0,
)

observation2 = weather_station2.snotel_weather_observations.create!(
  date: Date.yesterday,
  time: Time.now - 1.hour,
  temp: 30.0,
  max_temp: 32.0,
  min_temp: 28.0,
  wind_speed: 12.0,
  wind_direction: 200,
  wind_gust_speed: 18.0,
  melted_precipitation_1hr: 0.2,
  snow_height: 10.0,
  snow_water_equivalent: 4.0,
)

puts "Observation 1: #{observation1.inspect}"
puts "Observation 2: #{observation2.inspect}"