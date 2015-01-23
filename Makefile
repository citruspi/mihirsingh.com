all: clean build

clean:

	rm -r dist
	rm -f src/index.html

build:

	mkdir dist

	./node_modules/jade/bin/jade.js src/index.jade
	mv src/index.html dist/index.html

	mkdir dist/assets
	mkdir dist/assets/css
	sass src/assets/css/screen.sass dist/assets/css/screen.css

server: clean build

	cd dist && python -m SimpleHTTPServer

PHONY: build clean server
