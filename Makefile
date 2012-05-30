MELANGE=~/Open-Dylan/bin/melange

OPEN_DYLAN_USER_REGISTRIES = $(CURDIR)/registry

all: build

.PHONY: build test

libpq.dylan: libpq.intr $(MELANGE)
	$(MELANGE) -Tc-ffi -I/Library/PostgreSQL/9.0/include libpq.intr libpq.dylan

build: libpq.dylan
	dylan-compiler -build libpq

test: libpq.dylan
	dylan-compiler -build libpq-test-suite-app
	_build/bin/libpq-test-suite-app
