.PHONY: install
install:
	poetry export --without-hashes --without dev --format requirements.txt --output requirements.txt

.PHONY: clean_req
clean_req:
	bash clean_requirements.sh

.PHONY: black
black:
	black *.py

.PHONY: sort
sort:
	isort *.py

.PHONY: lint
lint:
	pylint *.py


all : install clean_req sort black lint
.PHONY : all