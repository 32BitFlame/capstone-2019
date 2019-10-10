extends HTTPRequest

var uri = 'https://jsonplaceholder.typicode.com/todos/1';
export (int) var net_iter_max;
var net_iter = 0;
func _ready():
	pass
func _process(delta):
	if(net_iter >= net_iter_max):
		net_iter = 0;
		# Poll http server
		print("Polling")
		var test = request(uri)
		print(test)
	net_iter+=1;
	
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var resultString = body.get_string_from_utf8()
	if(resultString == ""):
		return
	var json = JSON.parse(resultString);
	