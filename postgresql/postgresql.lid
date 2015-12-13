library:      postgresql
target-type:  dll
executable:   postgresql-dylan
license:      See License.txt in this distribution for details.
warranty:     Distributed WITHOUT WARRANTY OF ANY KIND
files:        library
              module-raw-postgresql
              module-postgresql
              raw-postgresql
              connection-control
              connection-status
              type-conversion
              execution
              execution-results
c-libraries:  -L`pg_config --libdir`
              -lpq
