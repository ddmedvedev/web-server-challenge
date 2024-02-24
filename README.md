## Web Server Challenge

### How is the code in this repo organized?
The code in this repo uses the following hierarchy:
```
root
  |-app
     |-source_code
     |  |-config.json
     |  |-server.py
     |-requirements.txt
  |-build
     |-Dockerfile
  |-deploy
     |-chart
        |-templates
            |-<chart template files>
        |-Chart.yaml
        |-values.yaml
     |-cluster-config.yaml
  |-docs
    |-application.md
  |-.gitignore
  |-Makefile
  |-README.md
```
Where:

***app*** - folder contains application code.

***build*** - folder with Dockerfile only.

***deploy*** - folder contains all dependencies to deploy application in Kubernetes cluster.

***docs*** - folder contains description of application.

### What’s happening in Makefile?

It has 5 steps:

1. `make build`  
During this step application is being built using [Docker](https://www.docker.com/)
2. `make create`  
During this step Kubernetes cluster is being created using [kind](https://kind.sigs.k8s.io/).
It consists of 3 nodes (control-plane and 2 worker nodes)
3. `make deploy`  
During this step previously builded application image is loaded into Kubernetes cluster (using kind's internal approach).
After that application deployed in cluster using [helm](https://helm.sh/) 
4. `make destroy`  
Step for destroying cluster and all it’s contents.
5. `make all`  
Do above steps one by one.

If you want not to destroy all resources right after successful deploy (e.g. for testing application purposes):
- exclude `destroy` step from `all`
- execute (locally):  
`kubectl port-forward service/web-server-challenge 12345:80 -n stage` (where 12345 your localhost port)  
You should not explicitly select context in kubectl (this is done after cluster creation during `deploy` step)

### What can be improved:
- app logging at start.  
When application starts - it shows nothing in output. You will see any output only after you will try to access application.
- specify namespace dynamically.
