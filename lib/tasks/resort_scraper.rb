require 'nokogiri'
require 'open-uri'
require_relative './config/environment' # to connect to your Rails environment

class ResortStatus

    def initialize
        @resorts_lifts_trails = {}
    end

    def resorts_lifts_trails
        # Getter for accessing resorts_lifts_trails from outside the class since instance variables are private by default
        @resorts_lifts_trails
    end

    def scrape_ArapahoeBasin
        url = 'https://www.arapahoebasin.com/the-mountain/terrain-status/'
        data = Nokogiri::HTML(URI.open(url))
        resort_name = 'Arapahoe Basin'
        lift_and_trails = {}
        current_lift = nil

        data.css('div.ab-status.ab-status-large').each do |lift|
            # Stop the iteration when we reach the unwanted section
            break if lift.parent[:class] == 'ab-snowReport_uphill'
            
            # Remove any non-text nodes (like SVG) from the lift node
            lift.children.each { |c| c.remove if c.name != 'text' }
            lift_name = lift.text.strip
            lift_status = lift.at_css('svg.status_open') ? 'open' : 'closed'
            lift_and_trails[lift_name] = {status: lift_status, trails: []}
            
            following_sibling = lift.next_element
            while following_sibling && following_sibling.name == 'button' && following_sibling[:class] == 'ab-status_wrapper'
            if following_sibling.at_css('div.ab-status_sub')
                following_sibling.css('div.ab-status_sub div.ab-status').each do |trail|
                # Remove any non-text nodes (like SVG) from the trail node
                trail.children.each { |c| c.remove if c.name != 'text' }
                trail_name = trail.text.strip
                trail_status = trail.at_css('svg.status_open') ? 'open' : 'closed'
                lift_and_trails[lift_name][:trails] << {name: trail_name, status: trail_status}
                end
            end
            following_sibling = following_sibling.next_element
            end
        end

        @resorts_lifts_trails[resort_name] = lift_and_trails
    end


    def scrape_CopperMountain
        # Skeleton function for a different resort/website
        url = 'https://www.example2.com/terrain-status/'
        data = Nokogiri::HTML(URI.open(url))
        resort_name = 'Example Ski Resort 2'
        lift_and_trails = {}
        # Insert your website 2 specific scraping logic here...

        @resorts_lifts_trails[resort_name] = lift_and_trails
    end


    def scrape_WinterPark
        # Skeleton function for a different resort/website
        url = 'https://www.example3.com/terrain-status/'
        data = Nokogiri::HTML(URI.open(url))
        resort_name = 'Example Ski Resort 3'
        lift_and_trails = {}
        # Insert your website 3 specific scraping logic here...

        @resorts_lifts_trails[resort_name] = lift_and_trails
    end

    def scrape_Eldora
        # Skeleton function for a different resort/website
        url = 'https://www.example3.com/terrain-status/'
        data = Nokogiri::HTML(URI.open(url))
        resort_name = 'Example Ski Resort 3'
        lift_and_trails = {}
        # Insert your website 4 specific scraping logic here...

        @resorts_lifts_trails[resort_name] = lift_and_trails
    end

    def run
        scrape_ArapahoeBasin
        #scrape_CopperMountain
        #scrape_WinterPark
        #scrape_Eldora
        upload_to_database
    end
    
    def upload_to_database
        @resorts_lifts_trails.each do |resort_name, lifts_and_trails|
            resort = Resort.find_or_create_by(name: resort_name)
            lifts_and_trails.each do |lift_name, lift_data|
                lift = resort.lifts.find_or_create_by(name: lift_name)
                lift.update(status: lift_data[:status])
                lift_data[:trails].each do |trail_data|
                    trail = lift.trails.find_or_create_by(name: trail_data[:name])
                    trail.update(status: trail_data[:status])
                end
            end
        end
    end

end
    
status = ResortStatus.new
status.run


# This code prints all of the data for testing/verification purposes
# status.resorts_lifts_trails.each do |resort, lift_and_trails|
#   puts "Resort Name: #{resort}"
#   lift_and_trails.each do |lift, lift_info|
#     puts "\tLift Name: #{lift}, Status: #{lift_info[:status]}"
#     lift_info[:trails].each do |trail|
#       puts "\t\tTrail Name: #{trail[:name]}, Status: #{trail[:status]}"
#     end
#   end
# end