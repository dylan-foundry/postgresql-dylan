Module: sql-postgresql-implementation
Synopsis: PostgreSQL backend for database library.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define concrete class <postgresql-database> (<database>)
  constant slot datasource-name :: <string>,
    required-init-keyword: datasource-name:;
end class;


define method make-dbms-specific
     (type == <database>, dbms :: <postgresql-dbms>, #rest more-args)
  => (database :: <postgresql-database>)
  apply(make, <postgresql-database>, more-args)
end method;
