release:
	docker build -t opszero/kube-nginx-websocket:$(shell git rev-parse HEAD) .
	docker push opszero/kube-nginx-websocket:$(shell git rev-parse HEAD)
