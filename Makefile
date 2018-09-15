TAG=dehypnosis/nexus-3.13.0-keycloak-4.3.0.final

all:
	docker build -t $(TAG) .
	docker push $(TAG)
