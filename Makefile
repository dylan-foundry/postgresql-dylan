MELANGE=melange

PG_INCLUDEDIR=`pg_config --includedir`

all: build

.PHONY: build test

postgresql.dylan: postgresql.intr
	$(MELANGE) -Tc-ffi -I$(PG_INCLUDEDIR) postgresql.intr postgresql.dylan

build: postgresql.dylan
	dylan-compiler -build postgresql

test: postgresql.dylan
	dylan-compiler -build postgresql-test-suite-app
	_build/bin/postgresql-test-suite-app

clean:
	rm -f postgresql.dylan
	rm -rf _build/bin/postgresql*
	rm -rf _build/lib/*postgresql*
	rm -rf _build/build/postgresql*
