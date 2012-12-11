class Location

	def initialize(address)
		@address = address
	end

geocoded_by :full_street_address   # can also be an IP address
after_validation :geocode          # auto-fetch coordinates

result = request.location

	def coordinates()
		if (results = search(@address)).size > 0
			results.first.coordinates
		end
	end
end

Detect Location of HTTP Request

#Get current user's city and country (using IP address). A location method is added to the standard Rack::Request which returns a Geocoder::Result object:
# Rails controller or Sinatra app
city = request.location.city
country = request.location.country_code 