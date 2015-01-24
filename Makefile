COMMIT:=$(shell git log -1 --pretty=format:'%H')
BRANCH:=$(shell git branch | sed -n -e 's/^\* \(.*\)/\1/p')

all: clean build

clean:

	rm -rf dist
	rm -rf release
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

release: clean build

	mkdir release
	zip -r dist dist

	cp dist.zip release/$(COMMIT).zip
	cp dist.zip release/$(BRANCH).zip

	rm dist.zip

PHONY: build release clean server
