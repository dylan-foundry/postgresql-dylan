Module: sql-postgresql-test-suite
Author: eec
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define constant $dbms-class = <postgresql-dbms>;
define constant $dbms-user-class = <postgresql-user>;
define constant $dbms-database-class = <postgresql-database>;

define test dbms-make-test ()
  let dbms = make($dbms-class);
  assert-instance?($dbms-class, dbms);
  assert-signals(<condition>, make(<dbms>));
end test;

define test user-make-test ()
  let dbms = make($dbms-class);

  assert-instance?($dbms-user-class, make($dbms-user-class));
  assert-instance?($dbms-user-class,
                   with-dbms(dbms)
                     make(<user>)
                   end with-dbms);
  assert-signals(<dbms-not-specified>, make(<user>));
end test;

define test database-make-test ()
  let dbms = make($dbms-class);
  assert-instance?($dbms-database-class,
                   make($dbms-database-class, datasource-name: ""));
  assert-instance?($dbms-database-class,
                   with-dbms(dbms)
                     make(<database>, datasource-name: "")
                   end with-dbms);
  assert-signals(<dbms-not-specified>,
                 make(<database>, datasource-name: ""));
end test;

define suite creation-test-suite ()
  test dbms-make-test;
  test user-make-test;
  test database-make-test;
end suite;
