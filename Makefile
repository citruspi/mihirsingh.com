COMMIT:=$(shell git log -1 --pretty=format:'%H')
BRANCH:=$(TRAVIS_BRANCH)

ifeq ($(strip $(BRANCH)),)
	BRANCH:=$(shell git branch | sed -n -e 's/^\* \(.*\)/\1/p')
endif

all: clean dist

clean:

	rm -rf dist
	rm -rf release
	rm -f src/index.html

dist:

	mkdir dist

	./node_modules/jade/bin/jade.js src/index.jade
	mv src/index.html dist/index.html

	mkdir dist/assets
	mkdir dist/assets/css
	sass src/assets/css/screen.sass dist/assets/css/screen.css

server: clean dist

	cd dist && python -m SimpleHTTPServer

release: clean dist

	mkdir release
	cd dist && zip -r ../dist.zip .

	cp dist.zip release/$(COMMIT).zip
	cp dist.zip release/$(BRANCH).zip

	rm dist.zip

PHONY: dist release clean server
