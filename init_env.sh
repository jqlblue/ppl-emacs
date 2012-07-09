#!/bin/sh
ROOT=`pwd`
# init config
if test -e ~/.emacs
then
    mv ~/.emacs ~/.emacs.bak
fi

if test -d ~/.emacs.d
then
    mv ~/.emacs.d ~/.emacs.d.bak
fi
ln -s $ROOT ~/.emacs.d
ln -s $ROOT/emacs.index ~/.emacs

# install dependence

# for php relate
yum -y install php
yum -y install php-manual-en
yum -y install pyflakes
# for python
yum -y install ipython
easy_install rope
easy_install pymacs
# for common lisp
yum -y install sbcl
# for scheme (todo)
#tar zxvf scheme48-1.8.tgz
#cd scheme48-1.8/
#./configure --prefix=/usr/local/scheme48
#make
#make install
