PYTHON=python
PID=`bin/rabbitmqctl status | perl -n -e'/{pid,(\d+)/ && print $$1'`

all: rabbitmq_deps buildout rabbitmq_auth

rabbitmq_pid:
	echo ${PID} > run/rabbitmq.pid

rabbitmq_deps:
	sudo apt-get install erlang build-essential ncurses-dev libncurses-dev xsltproc -y

buildout:
	${PYTHON} bootstrap.py
	bin/buildout -vv

rabbitmq_auth:
	bin/rabbitmq-server &
	sleep 6
	bin/rabbitmqctl add_user test test
	bin/rabbitmqctl add_vhost myvhost
	bin/rabbitmqctl set_permissions -p myvhost test ".*" ".*" ".*"
	bin/rabbitmqctl stop
