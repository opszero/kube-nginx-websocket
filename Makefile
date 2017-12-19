timestamp = $(shell date +"%m%Y%HH%MM")
release:
	docker build -t opszero/kube-nginx-websocket:$(shell git rev-parse HEAD)$(timestamp) .
	docker push opszero/kube-nginx-websocket:$(shell git rev-parse HEAD)$(timestamp)

release-letsencrypt:
	docker build -t opszero/kube-nginx-websocket:letsencrypt .
	docker push opszero/kube-nginx-websocket:letsencrypt

release-letsencrypt-proxy-pass:
	docker build -t opszero/kube-nginx-websocket:letsencrypt-proxy-pass .
	docker push opszero/kube-nginx-websocket:letsencrypt-proxy-pass
