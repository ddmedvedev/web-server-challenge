from flask import Flask
from gevent.pywsgi import WSGIServer
import json
from os import environ

# Port value inject via env variable. In case if env don't set - use default value.
port = int(environ.get('APP_PORT', 5555))

# Paste port value in config file
with open('config.json', 'r+') as f:
    config = json.load(f)
    config['port'] = port
    f.seek(0)
    json.dump(config, f)
    f.truncate()

# Create a Flask app
app = Flask(__name__)

# Load config from updated JSON file
with open('config.json') as f:
    config = json.load(f)

# Extract message from config, if not available, use default value
message = config.get('message', 'Hello, World!')

# Define a route for the root URL
@app.route('/')
def index():
    return message

if __name__ == '__main__':
    # Debug/Development
    # Run the Flask app in debug mode, allowing for automatic reloading on code changes,
    # and listening on all available interfaces (0.0.0.0) on the specified port.
    # app.run(debug=True, host='0.0.0.0', port=port)

    # Production
    # Create a WSGI server listening on '0.0.0.0' (all available interfaces) and the specified port
    http_server = WSGIServer(('0.0.0.0', port), app)
    # Start serving requests indefinitely
    http_server.serve_forever()
