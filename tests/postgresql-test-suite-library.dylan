module: dylan-user

define library postgresql-test-suite
  use common-dylan;
  use io;
  use postgresql;
  use testworks;

  export postgresql-test-suite;
end library;

define module postgresql-test-suite
  use common-dylan;
  use format;
  use postgresql;
  use testworks;

  export postgresql-test-suite;
end module;
