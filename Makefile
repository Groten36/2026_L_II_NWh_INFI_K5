deps:
	pip install -r requirements.txt;\
		pip install -r test_requirements.txt
lint:
	flake8 hello_world test
run:
	python main.py
.PHONY: test
test:
	curl 127.0.0.1:5000/?output=json
	PYTHONPATH=. py.test
