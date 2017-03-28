timestamp = $(shell date +"%m%Y%HH%MM")
release:
	docker build -t opszero/kube-nginx-websocket:$(shell git rev-parse HEAD)$(timestamp) .
	docker push opszero/kube-nginx-websocket:$(shell git rev-parse HEAD)$(timestamp)
