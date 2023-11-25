module WeatherObservationsHelper
    def calculate_height(temp_fahrenheit)
      # Adjust the formula based on the Fahrenheit range you expect
      # Assuming max temperature is 120°F and height of SVG is 100
      (temp_fahrenheit.to_f / 120) * 100
    end
  
    def calculate_color(temp_fahrenheit)
      # Simple logic to change color based on temperature (Fahrenheit)
      if temp_fahrenheit < 50
        '#add8e6' # Light blue for colder temperatures
      elsif temp_fahrenheit < 80
        '#ffff00' # Yellow for mild temperatures
      else
        '#ff4500' # Orange-red for hot temperatures
      end
    end
  end
  