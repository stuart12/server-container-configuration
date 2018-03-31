# Hints
## build the image
	docker build --tag matrix-synapse --build-arg TURN_SECRET=turnit --build-arg DATABASE_PASSWORD=dbfoo .
## run the image
	docker run --interactive --tty matrix-synapse sh -i  
