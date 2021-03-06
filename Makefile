IS_CYGWIN := $(shell uname | sed -e '/.*\(CYGWIN\).*/!d;s//\1/')

COFFEE := coffee
MOCHA := mocha

ifneq ($(IS_CYGWIN),)
	COFFEE := $(shell cygpath "$(APPDATA)")/npm/coffee.cmd
	MOCHA := $(shell cygpath "$(APPDATA)")/npm/mocha.cmd
endif


lib/%.js: src/%.coffee
	$(COFFEE) -c -o lib src/*.coffee

test: lib/*.js
	$(MOCHA) --bail --require chai --require coffee-script --reporter list test/*.coffee
.PHONY: test
