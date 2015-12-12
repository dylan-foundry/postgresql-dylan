module: dylan-user

define library postgresql
  use common-dylan;
  use c-ffi;

  export postgresql;
  export %postgresql;
end library;
