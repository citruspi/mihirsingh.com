all: clean index

clean:

	rm index.html

index:

	./node_modules/jade/bin/jade.js index.jade

server: index

	python -m SimpleHTTPServer

PHONY: index clean server
