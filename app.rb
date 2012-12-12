require "sinatra"
require "sinatra/reloader"
require "debugger"
require "next_muni"
require "geocoder"

set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
	erb :index
end

post '/address' do 
	@address = params[:address]
	coordinates = Geocoder.search(@address)
	@latitude = coordinates[0].latitude
	@longitude = coordinates[0].longitude
	
	
	erb :result
end


