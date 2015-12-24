Module: sql-postgresql-test-suite
Author: eec
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND


define variable *ddl-connection* = #f;

define test create-table-test ()
  with-connection(*ddl-connection*)
    let stmt = make(<sql-statement>,
                    text: "create table dwsql (col_1 char(50), col_2 number)");
    let result = execute(stmt);
    assert-instance?(<empty-result-set>, result);

    let result = execute("drop table dwsql");
    assert-instance?(<empty-result-set>, result);
  end with-connection;
end test;

define test create-duplicate-table-test ()
  with-connection(*ddl-connection*)
    local method create-table()
            let stmt = make(<sql-statement>,
                            text: "create table dwsql (col_1 char(50), "
                              "col_2 number)");
            execute(stmt);
          end method;

    assert-no-errors(create-table());
    assert-signals(<syntax-error-or-access-rule-violation>,
                   create-table());
    let result = execute("drop table dwsql");
  end with-connection;
end test;


define method ddl-test-setup () => ()
  with-dbms($the-dbms)
    let database = make(<database>, datasource-name: $datasource-name);
    let user = make(<user>, user-name: $user-name, password: $user-password);
    *ddl-connection* := connect(database, user);
  end with-dbms;
end method;

define method ddl-test-cleanup() => ()
  disconnect(*ddl-connection*);
  *ddl-connection* := #f;
end method;

define suite ddl-test-suite (setup-function: ddl-test-setup,
                             cleanup-function: ddl-test-cleanup)
  test create-table-test;
  test create-duplicate-table-test;
end suite;
