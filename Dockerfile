FROM nginx

RUN apt-get update -y && apt-get install -y  ruby

ENV SOCKET_SERVER socket_server
COPY nginx.conf.erb /etc/nginx/nginx.conf.erb
COPY run.sh /

CMD ["bash", "/run.sh"]
