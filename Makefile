MELANGE=~/Open-Dylan/bin/melange

OPEN_DYLAN_USER_REGISTRIES = $(CURDIR)/registry

PG_INCLUDEDIR=`pg_config --includedir`

all: build

.PHONY: build test

pq.dylan: pq.intr $(MELANGE)
	$(MELANGE) -Tc-ffi -I$(PG_INCLUDEDIR) pq.intr pq.dylan

build: pq.dylan
	dylan-compiler -build pq

test: pq.dylan
	dylan-compiler -build pq-test-suite-app
	_build/bin/pq-test-suite-app
