extends HTTPRequest

var uri = 'http://localhost:8080'; #URI for the game server
export (int) var net_iter_max; #The number of frames inbetween server polls
var net_iter = 0;
var last_uuid = "";
var spawn;
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
	if typeof(json.result) == TYPE_ARRAY:
	    pass
	else:
		print(json.result['enemy'])
		if last_uuid != json.result['uuid']:
			print(last_uuid)
			print(json.result['uuid'])
			last_uuid = json.result['uuid']
			if(json.result['enemy'] == 'wolf'):
				spawn = get_parent().get_node("Enemy_Spawn")
				spawn.EN = 0
				spawn._Spawn_Enemy()
				print("Spawned!")
		else:
			print("No changes made")
