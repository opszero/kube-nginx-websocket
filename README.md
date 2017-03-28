# kube-nginx-websocket
Nginx container to load-balance websocket servers in Kubernetes

## Getting Started
This container is designed to be run in a pod in Kubernetes to proxy websocket requests to a socket server.
You can provide following environment variables to customize it.

```
# set env var to dns name of the socket server
SOCKET_SERVER=socket-service
```

This is supposed to work with the service exposed via AWS Elastic Loadbalancer. Make sure you [enable proxy protocol in your ELB](http://docs.aws.amazon.com/ElasticLoadBalancing/latest/DeveloperGuide/enable-proxy-protocol.html).

You should run this as a Kubernetes service. Remember to set `sessionAffinity: ClientIP` to both, this nginx and upstream socket service.

Example manifest:

```
apiVersion: v1
kind: Service
metadata:
  name: socket-app-nginx
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert: arn:aws:acm:us-west-2:<keyname>
    service.beta.kubernetes.io/aws-load-balancer-proxy-protocol: "*"
  labels:
    run: socket-app-nginx
spec:
  type: LoadBalancer
  ports:
  - name: https
    port: 443
    protocol: TCP
    targetPort: 8080
  - name: http
    port: 80
    protocol: TCP
    targetPort: 8080
  selector:
    run: socket-app-nginx-socket
  sessionAffinity: ClientIP
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: socket-app-nginx-socket
spec:
  replicas: 2
  template:
    metadata:
      labels:
        run: socket-app-nginx-socket
    spec:
      containers:
      - name: socket-app-nginx-socket
        image: apsops/kube-nginx-websocket:v0.3
        ports:
        - containerPort: 8080
        env:
          - name: SOCKET_SERVER
            value: socket-app
---
kind: Service
apiVersion: v1
metadata:
  name: socket-app
spec:
  selector:
    app: socket-app
  ports:
  - name: http
    protocol: TCP
    port: 80
    targetPort: 4000
  sessionAffinity: ClientIP
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: socket-app
spec:
  replicas: 2
  template:
    metadata:
      labels:
        app: socket-app
    spec:
      containers:
      - name: socket-app
        image: socket/app:latest
        ports:
        - containerPort: 4000
```

## Contributing
I plan to make this more modular and reliable.

Feel free to open issues and pull requests for bug fixes or features.

## Licence

This project is licensed under the MIT License. Refer [LICENSE](https://github.com/ApsOps/kube-nginx-websocket/blob/master/LICENSE) for details.
