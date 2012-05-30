module: dylan-user

define library pq-test-suite
  use common-dylan;
  use io;
  use pq;
  use testworks;

  export pq-test-suite;
end library;

define module pq-test-suite
  use common-dylan, exclude: { format-to-string };
  use format;
  use pq;
  use testworks;

  export pq-test-suite;
end module;
