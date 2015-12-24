module: sql-postgresql-test-suite
synopsis: Test suite for the sql-postgresql library.

define variable $the-dbms = make(<postgresql-dbms>);

define variable $datasource-name = "";
define variable $user-name = "";
define variable $user-password = "";

define suite sql-postgresql-test-suite ()
  suite creation-test-suite;
  suite connection-test-suite;
  suite ddl-test-suite;
  suite dml-test-suite;
end suite;
