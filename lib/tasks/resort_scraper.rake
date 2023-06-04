require 'nokogiri'
require 'open-uri'

namespace :resort do
    desc 'Scrape resort data'
    task scrape: :environment do
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
                resort_name = 'Arapahoe Basin'
                data = Nokogiri::HTML(URI.open(url))
                lift_and_trails = {}
                current_lift = nil
            
                data.css('div.ab-status.ab-status-large').each do |lift|
                    break if lift.parent[:class] == 'ab-snowReport_uphill'
                    
                    lift_name = lift.text.gsub(/\s+/, ' ').strip
                    lift_name = lift_name.gsub(/.*?(.status_|.level_)*([A-Za-z'’0-9\s().-]+)$/, '\2').split(' .').first.chomp(',').strip
                    lift_status = lift.at_css('svg.status_open') ? 'open' : (lift.at_css('svg.status_closed') ? 'closed' : 'unknown')
            
                    next if lift_name.match(/[A-Za-z]/).nil?
                    
                    lift_and_trails[lift_name] = {status: lift_status, trails: []}
            
                    following_sibling = lift.next_element
                    while following_sibling && following_sibling.name == 'button' && following_sibling[:class] == 'ab-status_wrapper'
                        if following_sibling.at_css('div.ab-status_sub')
                            following_sibling.css('div.ab-status_sub div.ab-status').each do |trail|
                                trail_text = trail.inner_text.gsub(/\s+/, ' ').strip
                                trail_name = trail_text.gsub(/.*?(.status_|.level_)*([A-Za-z'’0-9\s().-]+)$/, '\2').split(' .').first.strip
                                
                                if trail_name.start_with? ","
                                    trail_name = trail_name[1..-1].strip
                                else
                                    trail_name = trail_name.chomp(',').strip
                                end
            
                                # Check for the second case of the trail
                                if trail.at_css('div.ab-status_groomed')
                                    trail_name = trail.inner_text.strip
                                    trail_name = trail_name.gsub(/\.[-_a-z0-9]+\{[^\}]+\}/, '')  # remove CSS style declarations
                                    trail_name = trail_name.strip  # remove leading/trailing whitespaces
                                end
            
                                trail_status = trail.at_css('svg.status_open') ? 'open' : (trail.at_css('svg.status_closed') ? 'closed' : 'unknown')
                                
                                next if trail_name.match(/[A-Za-z]/).nil? 
                                next if trail_name == trail.text 
                                
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
                    resort = Resort.find_or_initialize_by(name: resort_name)
                    resort.save
                    lifts_and_trails.each do |lift_name, lift_data|
                        lift = resort.lifts.find_or_initialize_by(name: lift_name)
                        lift.update(status: lift_data[:status])
                        lift.save
                        lift_data[:trails].each do |trail_data|
                            trail = lift.trails.find_or_initialize_by(name: trail_data[:name])
                            trail.update(status: trail_data[:status])
                            trail.save
                        end
                    end
                end
            end
            
            
        end
            
        status = ResortStatus.new
        status.run
        
    end
end

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