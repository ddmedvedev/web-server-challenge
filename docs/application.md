### Application description
Despite application code itself is commented, this file will also contain application description.

Application is written on [Python](http://python.org). It uses Flask framework.

Application is a web-server whose only task is display value of key `message` from `config.json`.
That config file also has another important function - it defines the port on which the application runs.
If environment variable `APP_PORT` exists - application will use it's value.
Otherwise, application will use default port from 

#### How to handle requirements.txt?
This is standard Python file which contain all requirements for application.
To update \ create file you can use
- [pip](https://pypi.org/project/pip/) (in case you are using venv):  
`cd app`  
`pip3 freeze > requirements.txt`
- [pipreqs](https://pypi.org/project/pipreqs/):  
`cd app`  
`pip install --no-deps pipreqs`  
`pipreqs .`

#### Notice for macOS users
Starting from macOS Monterey, default Flask port (5000) are in-use by AirPlay Receiver. 
For running application locally you probably should turn off AirPlay Receiver from System Settings > General > AirPlay Receiver > Disable AirPlay Receiver option.