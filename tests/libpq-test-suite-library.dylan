module: dylan-user

define library libpq-test-suite
  use common-dylan;
  use io;
  use libpq;
  use testworks;

  export libpq-test-suite;
end library;

define module libpq-test-suite
  use common-dylan, exclude: { format-to-string };
  use format;
  use libpq;
  use testworks;

  export libpq-test-suite;
end module;
