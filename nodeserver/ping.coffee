request = require('request')

# Keep Alive
class Ping
	req = 
		uri: "https://swordfishdev.herokuapp.com"
	console.log req
	do: ->
		setTimeout -> 
			console.log "inside timer"
			request req, (err, response, body) ->
				# console.log body
				setInterval -> 
					console.log "inside interval"
					request req, (err, response, body) ->
						# console.log body
				, 1800000		
		, 5000		

module.exports = Ping
