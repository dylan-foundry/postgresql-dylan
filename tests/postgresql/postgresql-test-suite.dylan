module: postgresql-test-suite
synopsis: Test suite for the postgresql library.

define suite postgresql-test-suite ()
  suite connection-test-suite;
  suite result-test-suite;
  suite prepared-test-suite;
end suite;
