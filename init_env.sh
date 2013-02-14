#!/bin/sh

# install dependence

# for php relate
yum -y install php
yum -y install phpcs

# for python
cd ~/.emacs.d/third-env/compile
git clone git://github.com/pinard/Pymacs.git
cd Pymacs
make install
cp pymacs.el ~/.emacs.d/site-lisp/
ln -s ~/.emacs.d/script/pycheckers ~/bin/pycheckers

# for common lisp
yum -y install sbcl
