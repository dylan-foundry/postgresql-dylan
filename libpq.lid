library:      libpq
target-type:  dll
license:      See License.txt in this distribution for details.
warranty:     Distributed WITHOUT WARRANTY OF ANY KIND
files:        library
              libpq
c-libraries:  -L`pg_config --libdir`
              -lpq
