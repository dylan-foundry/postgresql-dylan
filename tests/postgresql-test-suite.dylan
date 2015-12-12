module: postgresql-test-suite
synopsis: Test suite for the postgresql library.

define test empty-postgresql ()
end test empty-postgresql;

define suite postgresql-test-suite ()
  test empty-postgresql;
end suite;
