build:
	docker build . -t birdclef
run: build
	docker run birdclef