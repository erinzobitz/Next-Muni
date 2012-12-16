require "sinatra"
require "sinatra/reloader"
require "debugger"
require "geocoder"
require "muni"

set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
	erb :index
end

post '/address' do 
	@address = params[:address] #This is how the ruby server talks to the javascript
	coordinates = Geocoder.search(@address)
	@my_address = [coordinates[0].latitude, coordinates[0].longitude]
	@near_busses = []
	epochTimeInMilliSeconds = 0
	r = Muni::Base.send(:fetch, "vehicleLocations", {:t => epochTimeInMilliSeconds})
	vehicles = r.fetch("vehicle")

	vehicles.each do |vehicle|
		lat2 = vehicle.fetch("lat").to_f
		lon2 = vehicle.fetch("lon").to_f
		lat1 = coordinates[0].latitude
		lon1 = coordinates[0].longitude
		#found the following at http://snipplr.com/view/25479/
		radius = 6371 #km (change this constant to get miles)
		dLat = (lat2 - lat1) * Math::PI / 180 #distance using curvature of earth?
		dLon = (lon2 - lon1) * Math::PI / 180
		a = Math.sin(dLat/2) * Math.sin(dLat/2) +
		Math.cos(lat1 * Math::PI / 180 ) * Math.cos(lat2 * Math::PI / 180 ) *
		Math.sin(dLon/2) * Math.sin(dLon/2) #total of distance?
		c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)) #arclength?
		d = radius * c #distance?

		if d < 1
			@near_busses.push(vehicle)
			
		end
	end
	puts @near_busses
	erb :result
end

