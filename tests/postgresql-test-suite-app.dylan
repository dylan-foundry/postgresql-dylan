module: postgresql-test-suite-app

define suite all-postgresql-test-suites ()
  suite postgresql-test-suite;
  suite sql-postgresql-test-suite;
end suite;

run-test-application(all-postgresql-test-suites);
