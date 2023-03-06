class WeatherController < ApplicationController
def index
    
  render({ :template => "weather/index.html.erb" })
end

def show
  user_location = params.fetch("user_location")
  gmaps_key = ENV.fetch("GMAPS_KEY")

  gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_key}"

  raw_gmaps_data = URI.open(gmaps_url).read

  parsed_gmaps_data = JSON.parse(raw_gmaps_data)

  results_array = parsed_gmaps_data.fetch("results")

  first_result_hash = results_array.at(0)

  geometry_hash = first_result_hash.fetch("geometry")

  location_hash = geometry_hash.fetch("location")

  @latitude = location_hash.fetch("lat")

  @longitude = location_hash.fetch("lng")


   #Get the weather from Dark Sky API

   dark_sky_key = ENV.fetch("DARK_SKY_KEY")

   dark_sky_url = "https://api.darksky.net/forecast/#{dark_sky_key}/#{@latitude},#{@longitude}"


   raw_dark_sky_data = URI.open(dark_sky_url).read

   parsed_dark_sky_data = JSON.parse(raw_dark_sky_data)

   currently_hash = parsed_dark_sky_data.fetch("currently")

   @temp = currently_hash.fetch("temperature").to_i
   matching_tops = Top.all

  @list_of_tops = matching_tops.order({ :created_at => :desc })
  matching_bottoms = Bottom.all

  @list_of_bottoms = matching_bottoms.order({ :created_at => :desc })

      
      render({ :template => "weather/show.html.erb" })
end
end
