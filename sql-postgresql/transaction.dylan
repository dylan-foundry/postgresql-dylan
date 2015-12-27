Module: sql-postgresql-implementation
Synopsis: PostgreSQL backend for database library.
Author: eec
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND


define sealed concrete class <postgresql-transaction> (<transaction>)
  slot connection :: <postgresql-connection>,
    required-init-keyword: connection:;

  constant slot autocommit? :: <boolean>,
    required-init-keyword: autocommit?:;
end class;


define method default-diagnostics-size(connection :: <postgresql-connection>)
 => (diagnostics-size :: <integer>)
  5
end method;

define method default-transaction-mode(connection :: <postgresql-connection>)
 => (mode :: <transaction-mode>)
  $read-write
end method;

define method default-isolation-level(connection :: <postgresql-connection>)
 => (level :: <isolation-level>)
/*
  let (return-code, postgresql-isolation-level)
    = nice-SQLGetInfo(connection.%connection-handle,
                      $sql-default-txn-isolation);

  assert-postgresql-goodness(return-code,
                       connection.dbms.%environment-handle,
                       connection.%connection-handle,
                       $null-statement-handle);

  let isolation-level
    = select (postgresql-isolation-level)
              $sql-txn-read-uncommitted => $read-uncommitted;
              $sql-txn-read-committed => $read-committed;
              $sql-txn-repeatable-read => $repeatable-read;
              $sql-txn-serializable => $serializable;
              otherwise
                let msg = format-to-string("Unknown isolation level %x",
                                           postgresql-isolation-level);
                error(msg);
      end select;
  isolation-level;
*/
  $read-committed
end method;


define method start-transaction(connection :: <postgresql-connection>,
                                working-transaction-mode :: <transaction-mode>,
                                working-isolation-level :: <isolation-level>,
                                working-diagnostics-size :: <integer>)
 => (transaction :: <postgresql-transaction>)
  let save-autocommit-mode = get-autocommit-mode(connection);
  let save-transaction-mode = get-transaction-mode(connection);
  let save-isolation-level = get-isolation-level(connection);
  let save-diagnostics-size = get-diagnostics-size(connection);

  let transaction = make(<postgresql-transaction>,
                         connection: connection,
                         transaction-mode: save-transaction-mode,
                         isolation-level: save-isolation-level,
                         diagnostics-size: save-diagnostics-size,
                         autocommit?: save-autocommit-mode);

  set-isolation-level(connection, working-isolation-level);
  set-autocommit-mode(connection, #f);
  set-transaction-mode(connection, working-transaction-mode);
  set-diagnostics-size(connection, working-diagnostics-size);

  transaction;
end method;


define method end-transaction(transaction :: <postgresql-transaction>)
 => ()
  set-autocommit-mode(transaction.connection, transaction.autocommit?);
  set-transaction-mode(transaction.connection, transaction.transaction-mode);
  set-isolation-level(transaction.connection, transaction.isolation-level);
  set-diagnostics-size(transaction.connection, transaction.diagnostics-size);
end method;


define method rollback-transaction(transaction :: <postgresql-transaction>)
 => ()
/*
  let connection = transaction.connection;
  let return-code = SQLTransact(connection.dbms.%environment-handle,
                                connection.%connection-handle,
                                $sql-rollback);
  assert-postgresql-goodness(return-code,
                       connection.dbms.%environment-handle,
                       connection.%connection-handle,
                       $null-statement-handle);
*/
end method;


define method commit-transaction(transaction :: <postgresql-transaction>)
 => ()
/*
  let connection = transaction.connection;
  let return-code = SQLTransact(connection.dbms.%environment-handle,
                                connection.%connection-handle,
                                $sql-commit);
  assert-postgresql-goodness(return-code,
                       connection.dbms.%environment-handle,
                       connection.%connection-handle,
                       $null-statement-handle);
*/
end method;



define function set-autocommit-mode(connection :: <postgresql-connection>,
                                    autocommit? :: <boolean>)
 => ()
/*
  let return-code = nice-SQLSetConnectAttr(connection.%connection-handle,
                                           $sql-attr-autocommit,
                                           if (autocommit?)
                                             $sql-autocommit-on
                                           else
                                             $sql-autocommit-off
                                           end if);
  assert-postgresql-goodness(return-code,
                       connection.dbms.%environment-handle,
                       connection.%connection-handle,
                       $null-statement-handle);
*/
end function;

define function get-autocommit-mode(connection :: <postgresql-connection>)
 => (autocommit-mode :: <boolean>)
/*
  let (return-code, sql-autocommit) =
    nice-SQLGetConnectAttr(connection.%connection-handle,
                           $sql-attr-autocommit);
  assert-postgresql-goodness(return-code,
                       connection.dbms.%environment-handle,
                       connection.%connection-handle,
                       $null-statement-handle);
  sql-autocommit = $sql-autocommit-on;
*/
  #f
end function;


define function set-transaction-mode(connection :: <postgresql-connection>,
                                     transaction-mode :: <transaction-mode>)
 => ()
/*
  let return-code = nice-SQLSetConnectAttr(connection.%connection-handle,
                                        $sql-attr-access-mode,
                                        if (transaction-mode = $read-only)
                                          $sql-mode-read-only
                                        else
                                          $sql-mode-read-write
                                        end if);
  assert-postgresql-goodness(return-code,
                       connection.dbms.%environment-handle,
                       connection.%connection-handle,
                       $null-statement-handle);
*/
end function;


define function get-transaction-mode(connection :: <postgresql-connection>)
 => (transaction-mode :: <transaction-mode>)
/*
  let (return-code, sql-access-mode) =
    nice-SQLGetConnectAttr(connection.%connection-handle,
                           $sql-attr-access-mode);
  assert-postgresql-goodness(return-code,
                       connection.dbms.%environment-handle,
                       connection.%connection-handle,
                       $null-statement-handle);
  if (sql-access-mode = $sql-mode-read-only)
    $read-only
  else
    $read-write
  end if;
*/
  $read-write
end function;


define function set-isolation-level(connection :: <postgresql-connection>,
                                    isolation-level :: <isolation-level>)
 => ()
/*
  let return-code = nice-SQLSetConnectAttr(connection.%connection-handle,
                                        $sql-attr-txn-isolation,
                                        select (isolation-level)
                                          $read-uncommitted =>
                                            $SQL-TXN-READ-UNCOMMITTED;
                                          $read-committed =>
                                            $SQL-TXN-READ-COMMITTED;
                                          $repeatable-read =>
                                            $SQL-TXN-REPEATABLE-READ;
                                          $serializable =>
                                            $SQL-TXN-SERIALIZABLE;
                                        end select);
  assert-postgresql-goodness(return-code,
                       connection.dbms.%environment-handle,
                       connection.%connection-handle,
                       $null-statement-handle);
*/
end function;


define function get-isolation-level(connection :: <postgresql-connection>)
 => (isolatio-level :: <isolation-level>)
/*
  let (return-code, sql-txn-isolation) =
    nice-SQLGetConnectAttr(connection.%connection-handle,
                             $sql-attr-txn-isolation);
  assert-postgresql-goodness(return-code,
                       connection.dbms.%environment-handle,
                       connection.%connection-handle,
                       $null-statement-handle);

  let isolation-level = select (sql-txn-isolation)
                          $SQL-TXN-READ-UNCOMMITTED => $read-uncommitted;
                          $SQL-TXN-READ-COMMITTED => $read-committed;
                          $SQL-TXN-REPEATABLE-READ => $repeatable-read;
                          $SQL-TXN-SERIALIZABLE => $serializable;
                            // Versioning is stronger than serializable
                            // Oracle's read consistency isolation level is
                            // an example of versioning
                          $SQL-TXN-VERSIONING => $serializable;
                        end select;
  isolation-level;
*/
  $read-committed
end function;


define function set-diagnostics-size(connection :: <postgresql-connection>,
                                     diagnostics-size :: <integer>)
 => ()

end function;


define function get-diagnostics-size(connection :: <postgresql-connection>)
 => (diagnostics-size :: <integer>)
  5;
end function;
