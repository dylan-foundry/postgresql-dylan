module: dylan-user

define library sql-postgresql
  use common-dylan;
  use io;
  use postgresql;
  use sql;

  export sql-postgresql;
end library;

define module sql-postgresql
  use sql, import: all, export: all;

  create <postgresql-dbms>,
         <postgresql-database>,
         <postgresql-user>,
         <postgresql-connection>,
         <postgresql-sql-statement>;
end module;

define module sql-postgresql-implementation
  use dylan;
  use common-dylan;
  use finalization;
  use format;
  use sql;
  use threads;
  use postgresql;
  use sql-postgresql;
end module;
