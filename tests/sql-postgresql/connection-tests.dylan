Module: sql-postgresql-test-suite
Author: eec
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND


define test single-connection-test ()
  with-dbms($the-dbms)
    assert-signals(<connection-exception>,
                   block ()
                     let connection =
                       connect(make(<database>,
                                    datasource-name: "bad-db-name"),
                               make(<user>,
                                    user-name: $user-name,
                                    password: $user-password));
                     // In the event a condition is not thrown, disconnect
                     // from the database.
                     disconnect(connection);
                   end block);

    check("Connection test: good datasource-name",
          method ()
            let connection = connect(make(<database>,
                                          datasource-name: $datasource-name),
                                     make(<user>,
                                          user-name: $user-name,
                                          password: $user-password));
            disconnect(connection);
            #t
          end method);

    check("Connection test: short-cut",
          method ()
            let db = make(<database>, datasource-name: $datasource-name);
            let user = make(<user>,
                            user-name: $user-name,
                            password: $user-password);
            let connection = connect(db, user);
            disconnect(connection);
            #t;
          end method);
  end with-dbms;

  assert-signals(<dbms-not-specified>,
                 connect(make(<database>,
                              datasource-name: $datasource-name),
                         make(<user>,
                              user-name: $user-name,
                              password: $user-password)));
end test;

define test multiple-connection-test ()
  with-dbms($the-dbms)
    check("Multiple connections test",
          method ()
            let db = make(<postgresql-database>,
                          datasource-name: $datasource-name);
            let user = make(<postgresql-user>,
                            user-name: $user-name,
                            password: $user-password);
            let a-connection = connect(db, user);
            let b-connection = connect(db, user);
            disconnect(a-connection);
            disconnect(b-connection);
            #t
          end method);
  end with-dbms;
end test;

define test misc-connection-functions-test ()
  with-dbms($the-dbms)
    let con = connect(make(<postgresql-database>,
                           datasource-name: $datasource-name),
                      make(<postgresql-user>, user-name: $user-name,
                           password: $user-password),
                      dbms: $the-dbms);
  assert-equal(1, size(connections()));
  assert-equal(con, connections()[0]);
  disconnect-all(dbms: make(<postgresql-dbms>));
  assert-equal(1, size(connections()));
  disconnect-all();
  assert-equal(0, size(connections()));
  end with-dbms;
end test;

define suite connection-test-suite ()
  test single-connection-test;
  test multiple-connection-test;
  test misc-connection-functions-test;
end suite;
