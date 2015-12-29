Module: sql-postgresql-implementation
Synopsis: PostgreSQL backend for database library.
Author: Bruce Mitchener, Jr.
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define variable *prepared-counter* :: <integer> = 0;

define concrete class <postgresql-sql-statement> (<sql-statement>)
  slot connection :: <postgresql-connection> = default-connection(),
    init-keyword: connection:;

  slot %statement-name :: false-or(<string>) = #f,
    init-keyword: statement-name:;
end class;

define method make-dbms-specific
    (type == <sql-statement>, dbms :: <postgresql-dbms>, #rest more-args)
 => (sql-statement :: <postgresql-sql-statement>)
  apply(make, <postgresql-sql-statement>, more-args);
end method;

define method initialize
    (stmt :: <postgresql-sql-statement>, #key)
 => ()
  next-method();

  if (~stmt.%statement-name)
    stmt.%statement-name := format-to-string("prepared-%d", *prepared-counter*);
    *prepared-counter* := *prepared-counter* + 1;
  end if;

  let res = pg-prepare(stmt.connection.%connection-handle,
                       stmt.%statement-name,
                       stmt.text);
  assert-postgresql-goodness(res, stmt.connection);

  // Setup for finalization.
  finalize-when-unreachable(stmt);
  stmt.connection.%allocated-sql-statements[stmt] := #t;
end method;

define method statement-column-names
    (statement :: <postgresql-sql-statement>)
 => (column-names :: <simple-object-vector>)
  let res = pg-describe-prepared(statement.connection.%connection-handle,
                                 statement.%statement-name);
  assert-postgresql-goodness(res, statement.connection);
  let column-count = pg-result-num-fields(res);
  let column-names = make(<simple-object-vector>, size: column-count);
  for (column :: <integer> from 0 below column-count)
    column-names[column] := pg-result-field-name(res, column);
  end for;
  column-names
end method statement-column-names;

define constant $sql-statement-finalization-lock :: <lock> = make(<lock>);
// This seems like a heavy handed thing to do: halting all finalization on
// sql-statements on all other threads just to finalize a single instance.
// The alternative, each instance of <postgresql-sql-statement> could have it's
// own lock object but I don't like the idea of creating many locks. So,
// I don't expect this synchronization issue to occur much so doing the
// heavy-handed thing shouldn't be a big deal (I think).
define method finalize
    (statement :: <postgresql-sql-statement>)
 => ()
  with-lock($sql-statement-finalization-lock)
    let stmt-name = statement.%statement-name;
    if (stmt-name)
      let res = pg-execute(statement.connection.%connection-handle,
                           format-to-string("DEALLOCATE PREPARED \"%s\";",
                                            stmt-name));
      assert-postgresql-goodness(res, statement.connection);
      statement.%statement-name := #f;
    end
  end with-lock;

  next-method();
end method;


define method execute
    (statement :: <postgresql-sql-statement>,
     #key result-set-policy :: false-or(<result-set-policy>) = $default-result-set-policy,
          parameters :: <sequence> = #(),
          liaison :: false-or(<function>))
 => (result-set :: false-or(<result-set>))
  let res = apply(pg-execute-prepared,
                  statement.connection.%connection-handle,
                  statement.%statement-name,
                  parameters);
  assert-postgresql-goodness(res, statement.connection);
  if (result-set-policy)
    if (pg-result-status(res) = $PGRES-TUPLES-OK)
      make(<postgresql-result-set>,
           result-set-policy: result-set-policy,
           result: res,
           statement: statement,
           liaison: liaison);
    else
      make(<empty-result-set>, result: res);
    end if;
  end
end method;
