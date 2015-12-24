module: dylan-user

define library postgresql-test-suite-app
  use testworks;
  use postgresql-test-suite;
  use sql-postgresql-test-suite;
end library;

define module postgresql-test-suite-app
  use testworks;
  use postgresql-test-suite;
  use sql-postgresql-test-suite;
end module;
