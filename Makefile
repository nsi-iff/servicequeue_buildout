PYTHON=python

all: rabbitmq_deps buildout

rabbitmq_deps:
	sudo apt-get install erlang -y

buildout:
	${PYTHON} bootstrap.py
	bin/buildout -vv
