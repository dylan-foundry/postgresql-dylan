Module: sql-postgresql-implementation
Synopsis: PostgreSQL backend for database library.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define concrete class <postgresql-dbms> (<dbms>)
  constant slot %allocated-connections = make(<table>, weak: #"key");
end class;

define method initialize
    (dbmc :: <postgresql-dbms>, #key)
 => ()
  next-method();

  finalize-when-unreachable(dbms);
end method;

define method finalize (dbms :: <postgresql-dbms>) => ()
  do(finalize, dbms.%allocated-connections.key-sequence);
  next-method();
end method;
