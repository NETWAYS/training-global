RUNTIME?=docker
VERSION?=0.20.3

image:
	$(RUNTIME) build --pull -t docker.io/netways/showoff:$(VERSION) .
