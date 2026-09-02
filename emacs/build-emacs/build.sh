#!/bin/sh

# The current Emacs build script is MacOSX dependent.

# https://mgmarlow.com/words/2022-09-08-building-emacs-mac-os/

os=$(uname -s);

case "$os" in
    Darwin*)
        echo "Installing OSX dependencies.";
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
        ;;
    Linux*)
        echo "Installing Ubuntu dependencies.";
        sudo sed -i 's/^Types: deb$/Types: deb deb-src/' /etc/apt/sources.list.d/ubuntu.sources;
        sudo apt update;
        sudo apt build-dep -y emacs;
        sudo apt install libtree-sitter-dev;
        ;;
esac

mkdir -p src && cd src;

git clone --depth 1 --branch emacs-31 https://git.savannah.gnu.org/git/emacs.git;

cd emacs;

# Create separate build location to not pollute the repository.
# git worktree add ../emacs-31 emacs-31;
# cd ../emacs-31;

# Build.
CC="gcc-15" ./autogen.sh;

case "$os" in
    Darwin*)
        echo "Adding OSX flags".
        EXTRA_FLAGS="--with-ns --with-xwidgets";
        ;;
    Linux*)
        echo "Adding Ubuntu flags".
        EXTRA_FLAGS="";
        ;;
esac

CFLAGS='-O2 -march=native' \
      ./configure \
      --disable-acl \
	  --disable-silent-rules \
	  --with-gnutls \
	  --without-x \
	  --with-xml2 \
	  --without-dbus \
	  --without-selinux \
	  --without-pop \
	  --without-mailutils \
	  --with-tree-sitter \
	  --with-native-compilation=aot \
	  --without-compress-install \
      $EXTRA_FLAGS;

make -j8 bootstrap;
