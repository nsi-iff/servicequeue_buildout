PYTHON=python

all: rabbitmq_deps buildout rabbitmq_auth

rabbitmq_deps:
	sudo apt-get install erlang -y

buildout:
	${PYTHON} bootstrap.py
	bin/buildout -vv

rabbitmq_auth:
	bin/rabbitmq-server -detached
	bin/rabbitmqctl add_user test test
	bin/rabbitmqctl add_vhost myvhost
	bin/rabbitmqctl set_permissions -p myvhost test ".*" ".*" ".*"
	bin/rabbitmqctl stop
