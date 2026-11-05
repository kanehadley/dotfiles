

mkdir -p src && cd src

git clone --depth 1 --branch emacs-31 git://git.savannah.gnu.org/emacs.git

cd emacs

git checkout emacs-31

sudo sed -i 's/^Types: deb$/Types: deb deb-src/' /etc/apt/sources.list.d/ubuntu.sources && sudo apt update


sudo apt build-dep -y emacs

sudo apt install libtree-sitter-dev

./autogen.sh

./configure --disable-acl --disable-silent-rules --with-gnutls --without-x --with-xml2 --without-dbus --without-selinux --without-pop --without-mailutils --with-tree-sitter --with-native-compilation=aot --without-compress-install;

sudo make install


