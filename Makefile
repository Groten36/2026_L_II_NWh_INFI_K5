USERNAME=Groten36
TAG=$(USERNAME)/hello-world-printer

deps:
	pip install -r requirements.txt
	pip install -r test_requirements.txt

lint:
	flake8 hello_world test

run:
	python main.py

.PHONY: test
test:
	curl 127.0.0.1:5000/?output=json
	PYTHONPATH=. py.test

docker_build:
	docker build -t hello-world-printer .

docker_run: docker_build
	docker run \
	  --name hello-world-printer-dev \
	  -p 5000:5000 \
	  -d hello-world-printer

docker_push: docker_build
	echo "$${DOCKER_PASSWORD}" | docker login --username groten36 --password-stdin; \
	docker tag hello-world-printer $(TAG); \
	docker push $(TAG); \
	docker logout;
