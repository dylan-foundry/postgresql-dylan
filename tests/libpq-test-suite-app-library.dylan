module: dylan-user

define library libpq-test-suite-app
  use testworks;
  use libpq-test-suite;
end library;

define module libpq-test-suite-app
  use testworks;
  use libpq-test-suite;
end module;
