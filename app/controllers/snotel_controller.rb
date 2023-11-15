class SnotelController < ApplicationController

    before_action :find_station, only: [:show]

    def index
        @stations = SnotelWeatherStation.all
    end

    def show
        if @station
            @observations = @station.snotel_weather_observations
        else
            # Handle the case where the station is not found
            flash[:alert] = "Station not found."
            redirect_to snotel_index_path
        end
    end

    private

    def find_station
        @station = SnotelWeatherStation.find_by("LOWER(name) = ?", params[:station_name].downcase)
    end
end
  