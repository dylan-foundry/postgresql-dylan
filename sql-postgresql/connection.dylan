Module: sql-postgresql-implementation
Synopsis: PostgreSQL backend for database library.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define concrete class <postgresql-connection> (<connection>)
  constant slot user :: <postgresql-user>,
    required-init-keyword: user:;
  constant slot database :: <postgresql-database>,
    required-init-keyword: database:;
  slot %connection-handle :: <pg-connection> = $invalid-pg-connection,
    required-init-keyword: connection-handle:;
  constant slot %allocated-sql-statements = make(<table>, weak: #"key");
end class;

define method initialize
    (connection :: <postgresql-connection>,
     #key initial-value)
 => ()
  next-method();

  finalize-when-unreachable(connection);
  connection.dbms.%allocated-connections[connection] := #t;
end method;

define method finalize (connection :: <postgresql-connection>) => ()
  do(finalize, connection.%allocated-sql-statements.key-sequence);

  if (connection.%connection-handle ~= $invalid-pg-connection)
    disconnect(connection);
  end if;

  next-method();
end method;

define method connect
    (database :: <postgresql-database>,
     user :: <postgresql-user>,
     #key connection-string :: <string> = "",
          dbms :: <postgresql-dbms> = default-dbms())
 => (connection :: <postgresql-connection>)
  let pg-conn
    = if (connection-string = "")
        let connection-string = ""; // Use user and database here.
        ignore(database.datasource-name);
        ignore(user.user-name, user.password);
        pg-connect(connection-string);
      else
        pg-connect(connection-string);
      end if;
  let connection = make(<postgresql-connection>,
                        user: user, database: database,
                        connetion-handle: pg-conn,
                        dbms: dbms);

  with-lock (*all-connections-lock*)
    push-last(*all-connections*, connection);
  end with-lock;

  connection
end method;

define method disconnect
    (connection :: <postgresql-connection>,
     #key terminate-statements :: <boolean>)
 => ()
  pg-finish(connection.%connection-handle);
  connection.%connection-handle := $invalid-pg-connection;

  with-lock (*all-connections-lock*)
    remove!(*all-connections*, connection);
  end with-lock;
end method;
