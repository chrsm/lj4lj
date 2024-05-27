.DEFAULT_GOAL := all

DATE := $(shell TZ=UTC date +'%Y-%m-%d %H:%M:%S UTC')

# this is most certainly incorrect for people other than myself.
LUA_PATH=${HOME}/.luarocks/share/lua/5.1/?.lua;${HOME}/.luarocks/share/lua/5.1/?/init.lua;/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;./?.lua;./?/init.lua
LUA_CPATH=${HOME}/.luarocks/lib/lua/5.1/?.so;/usr/lib/lua/5.1/?.so
BUSTED_BIN=luajit ${HOME}/.luarocks/lib/luarocks/rocks-5.1/busted/2.2.0-1/bin/busted

.PHONY: all
all: build

.PHONY: build
build:
	cd src && yue -l -s -t ../lj4lj .
	cd spec && yue -l -s .

.PHONY: clean
clean:
	cd src && find . -type f -name '*.lua' -delete
	cd spec && find . -type f -name '*.lua' -delete

.PHONY: test
test: build
	${BUSTED_BIN} -v -C . -o gtest

.PHONY: help
help: Makefile
	@echo "$$(tput bold)Available commands:$$(tput sgr0)";echo;sed -ne"/^## /{h;s/.*//;:d" -e"H;n;s/^## //;td" -e"s/:.*//;G;s/\\n## /---/;s/\\n/ /g;p;}" ${MAKEFILE_LIST}|awk -F --- -v n=$$(tput cols) -v i=19 -v a="$$(tput setaf 6)" -v z="$$(tput sgr0)" '{printf"%s%*s%s ",a,-i,$$1,z;m=split($$2,w," ");l=n-i;for(j=1;j<=m;j++){l-=length(w[j])+1;if(l<= 0){l=n-i-length(w[j])-1;printf"\n%*s ",-i," ";}printf"%s ",w[j];}printf"\n";}'|more $(shell test $(shell uname) == Darwin && echo '-Xr')

