.DEFAULT_GOAL := all

DATE := $(shell TZ=UTC date +'%Y-%m-%d %H:%M:%S UTC')

.PHONY: all
all: build

.PHONY: build
build:
	cd lj4lj && yue -l -s .

.PHONY: clean
clean:
	cd lj4lj && find . -type f -name '*.lua' -delete

.PHONY: test
test: build
	busted -C lj4lj -o gtest

.PHONY: help
help: Makefile
	@echo "$$(tput bold)Available commands:$$(tput sgr0)";echo;sed -ne"/^## /{h;s/.*//;:d" -e"H;n;s/^## //;td" -e"s/:.*//;G;s/\\n## /---/;s/\\n/ /g;p;}" ${MAKEFILE_LIST}|awk -F --- -v n=$$(tput cols) -v i=19 -v a="$$(tput setaf 6)" -v z="$$(tput sgr0)" '{printf"%s%*s%s ",a,-i,$$1,z;m=split($$2,w," ");l=n-i;for(j=1;j<=m;j++){l-=length(w[j])+1;if(l<= 0){l=n-i-length(w[j])-1;printf"\n%*s ",-i," ";}printf"%s ",w[j];}printf"\n";}'|more $(shell test $(shell uname) == Darwin && echo '-Xr')

