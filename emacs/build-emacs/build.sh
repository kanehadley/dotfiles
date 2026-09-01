#!/bin/sh

# The current Emacs build script is MacOSX dependent.

# https://mgmarlow.com/words/2022-09-08-building-emacs-mac-os/

# Install dependencies.
brew install \
     pkg-config \
     automake \
     texinfo \
     jpeg \
     giflib \
     libtiff \
     jansson \
     libpng \
     librsvg \
     gnutls \
     libgccjit \
     tree-sitter;

mkdir src;

cd src;
git clone --depth 1 --branch emacs-31 https://git.savannah.gnu.org/git/emacs.git;
cd emacs;

# Create separate build location to not pollute the repository.
# git worktree add ../emacs-31 emacs-31;
# cd ../emacs-31;

# Build.
CC="gcc-15" ./autogen.sh;

CFLAGS='-O2 -march=native' \
      ./configure --disable-acl \
	  --disable-silent-rules \
	  --with-gnutls \
	  --without-x \
	  --with-xml2 \
	  --without-dbus \
	  --without-selinux \
	  --without-pop \
	  --without-mailutils \
	  --with-tree-sitter \
	  --with-ns \
	  --with-native-compilation=aot \
	  --with-xwidgets \
	  --without-compress-install;

make -j8 bootstrap;
