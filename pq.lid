library:      pq
target-type:  dll
executable:   pq-dylan
license:      See License.txt in this distribution for details.
warranty:     Distributed WITHOUT WARRANTY OF ANY KIND
files:        library
              pq
c-libraries:  -L`pg_config --libdir`
              -lpq
