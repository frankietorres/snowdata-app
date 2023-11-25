class SnotelController < ApplicationController
    before_action :find_station, only: [:show, :temperature_chart]
  
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
  
    # def temperature_chart
    #   if @station
    #     # Fetch observations for the last 7 days and order them
    #     @observations = @station.snotel_weather_observations
    #                             .where('time > ?', 7.days.ago)
    #                             .order(:time)
    #   else
    #     flash[:alert] = "Station not found."
    #     redirect_to snotel_index_path
    #   end
  
    #   # Additional check in case there are no observations in the last 7 days
    #   if @observations.blank?
    #     flash[:alert] = "No recent observations found for the station."
    #     redirect_to snotel_index_path
    #   end
    # end
  
    private
  
    def find_station
      @station = SnotelWeatherStation.find_by(name: params[:station_name])
    end
  end
  