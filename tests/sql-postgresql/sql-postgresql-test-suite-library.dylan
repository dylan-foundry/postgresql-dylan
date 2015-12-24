module: dylan-user

define library sql-postgresql-test-suite
  use common-dylan;
  use sql-postgresql;
  use testworks;

  export sql-postgresql-test-suite;
end library;

define module sql-postgresql-test-suite
  use common-dylan;
  use sql-postgresql;
  use testworks;

  export sql-postgresql-test-suite;
end module;
