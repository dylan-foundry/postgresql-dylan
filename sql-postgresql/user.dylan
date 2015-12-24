Module: sql-postgresql-implementation
Synopsis: PostgreSQL backend for database library.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define concrete class <postgresql-user> (<user>)
  constant slot user-name :: <string> = "",
    init-keyword: user-name:;
  constant slot password :: <string> = "",
    init-keyword: password:;
end class;

define method make-dbms-specific
    (type == <user>, dbms :: <postgresql-dbms>, #rest more-args)
 => (user :: <postgresql-user>)
  apply(make, <postgresql-user>, more-args)
end method;
