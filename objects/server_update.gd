extends HTTPRequest

var uri = 'https://jsonplaceholder.typicode.com/todos/1'; #URI for the game server

export (int) var net_iter_max; #The number of frames inbetween server polls
var net_iter = 0;
func _ready():
	pass
func _process(delta):
	if(net_iter >= net_iter_max): #Runs code when net iter reaches a specific number of frames
		net_iter = 0; #Resets net iter
		# Poll http server
		var test = request(uri)
	net_iter+=1;
	
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var resultString = body.get_string_from_utf8() #Dumps unicode string from request
	if(resultString == ""):
		return #ignores if no updates are indicated
	var json = JSON.parse(resultString); #Parses input into a dictionary
	