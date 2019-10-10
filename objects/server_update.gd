extends HTTPRequest

export (String) var uri;
export (int) var net_iter_max;
var net_iter = 0;
func _ready():
	pass
func _process(delta):
	if(net_iter >= net_iter_max):
		net_iter = 0;
		# Poll http server
		request(uri)
	net_iter+=1;
	
func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
    var json = JSON.parse(body.get_string_from_utf8())
    print_debug(json.result)