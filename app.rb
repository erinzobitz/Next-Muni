require "sinatra"
require "sinatra/reloader"
require "debugger"
require "next_muni"
require "geocoder"


set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
	erb :index
end

post '/location' do 
	@location = params[:location]
	coordinates = Geocoder.search(@location)
	@my_location = [coordinates[0].latitude, coordinates[0].longitude]
	
end


