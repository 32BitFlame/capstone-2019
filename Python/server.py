from flask import Flask, request
from json import loads, dumps
from hashlib import md5
live_servers = {}
app = Flask('app')


class Server:

    @staticmethod
    def Requestify(args):
        # Formats and Encodes message for efficency
        string = ""
        for key, value in args.items():
            string = f"{key}={value}".encode("ascii", "ignore")
        return string

    def __init__(self, ID):
        self._requests = []
        self.ID = ID

    def update_requests(self, key, val):
        pass  # Continue

    def get_requests(self):
        requests_buffer = self._requests
        self._requests = []
        return requests_buffer

# Check if id occupied
@app.route('/create', methods=['GET'])
def createServer():
    id = request.args.get('id')
    live_servers[id] = Server(id)
    return "200"


@app.route("/set", methods=['POST'])
def setServer():
    try:
        dat = request.get_json()
        print(dat)
        live_servers["id"].update_requests(dat["key"],dat["val"])
        return "200"
    except:
        return "400"


@app.route("/test")
def get():
    id = request.args.get('id')
    return live_servers[id].ID


app.run(host='0.0.0.0', port=8080)
