

build:
	sh build.sh

test:
	src/emacs/src/emacs --version

install:
	cd src/emacs; \
	make install; \
	mv nextstep/Emacs.app /Applications/;

clean:
	cd src/emacs; \
	make clean;

recreate:
	cd src/emacs; \
	make clean; \
	make bootstrap

launch-ui:
	CC="gcc-15" /Applications/Emacs.app/Contents/MacOS/Emacs
