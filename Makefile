MELANGE=melange

PG_INCLUDEDIR=`pg_config --includedir`

all: build

.PHONY: build test

pq.dylan: pq.intr
	$(MELANGE) -Tc-ffi -I$(PG_INCLUDEDIR) pq.intr pq.dylan

build: pq.dylan
	dylan-compiler -build pq

test: pq.dylan
	dylan-compiler -build pq-test-suite-app
	_build/bin/pq-test-suite-app

clean:
	rm -f pq.dylan
	rm -rf _build/bin/pq*
	rm -rf _build/lib/*pq*
	rm -rf _build/build/pq*
