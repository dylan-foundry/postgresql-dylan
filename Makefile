MELANGE=melange

PG_INCLUDEDIR=`pg_config --includedir`

all: build

.PHONY: build test

UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
  TARGET_PLATFORM=OPEN_DYLAN_TARGET_PLATFORM=x86_64-darwin
else
  TARGET_PLATFORM=
endif

postgresql/raw-postgresql.dylan: postgresql/raw-postgresql.intr
	$(MELANGE) -Tc-ffi -I$(PG_INCLUDEDIR) -m postgresql/module-raw-postgresql.dylan postgresql/raw-postgresql.intr postgresql/raw-postgresql.dylan

build: postgresql/raw-postgresql.dylan
	$(TARGET_PLATFORM) dylan-compiler -build postgresql
	$(TARGET_PLATFORM) dylan-compiler -build sql-postgresql

test: postgresql/raw-postgresql.dylan
	$(TARGET_PLATFORM) dylan-compiler -build postgresql-test-suite-app
	_build/bin/postgresql-test-suite-app

clean:
	rm -f postgresql/raw-postgresql.dylan
	rm -rf _build/bin/postgresql*
	rm -rf _build/lib/*postgresql*
	rm -rf _build/build/postgresql*
