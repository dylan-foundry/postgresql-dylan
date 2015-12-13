module: postgresql-test-suite
synopsis: Test suite for postgresql result handling.

define test result-fields-test ()
  let conn = pg-connect("");

  let res = pg-execute(conn, "SELECT 1 AS FOO, 2 AS \"BAR\";");
  assert-equal($PGRES-TUPLES-OK, pg-result-status(res));
  assert-equal(1, pg-result-num-tuples(res));
  assert-equal(2, pg-result-num-fields(res));
  assert-equal("foo", pg-result-field-name(res, 0));
  assert-equal("BAR", pg-result-field-name(res, 1));
  assert-equal(0, pg-result-field-number(res, "foo"));
  assert-equal(0, pg-result-field-number(res, "FOO"));
  assert-equal(-1, pg-result-field-number(res, "BAR"));
  assert-equal(1, pg-result-field-number(res, "\"BAR\""));
  assert-equal("1", pg-value(res, 0, 0));
  assert-equal("2", pg-value(res, 0, 1));
  assert-no-errors(pg-result-clear(res));

  let res = pg-execute(conn, "SELECT $1::text AS FOO", "Hello!");
  assert-equal($PGRES-TUPLES-OK, pg-result-status(res));
  assert-equal("", pg-result-error-message(res));
  assert-equal(1, pg-result-num-tuples(res));
  assert-equal(1, pg-result-num-fields(res));
  assert-equal("Hello!", pg-value(res, 0, 0));
  assert-no-errors(pg-result-clear(res));

  assert-no-errors(pg-finish(conn));
end test result-fields-test;

define function send-data-through-database
    (value :: <object>, type :: <string>)
 => (value :: <string>)
  let conn = pg-connect("");
  let q = format-to-string("SELECT $1::%s AS FOO", type);
  let res = pg-execute(conn, q, value);
  assert-equal($PGRES-TUPLES-OK, pg-result-status(res));
  assert-equal(1, pg-result-num-tuples(res));
  assert-equal(1, pg-result-num-fields(res));
  let r = pg-value(res, 0, 0);
  assert-no-errors(pg-result-clear(res));
  assert-no-errors(pg-finish(conn));
  r
end function send-data-through-database;

define test text-encoding-test ()
  assert-equal("f", send-data-through-database(#f, "boolean"));
  assert-equal("t", send-data-through-database(#t, "boolean"));
  assert-equal("-1", send-data-through-database(-1, "int4"));
  assert-equal("1568", send-data-through-database(1568, "int4"));
  assert-equal("Yo ho ho", send-data-through-database("Yo ho ho", "varchar"));
end test text-encoding-test;

define suite result-test-suite ()
  test result-fields-test;
  test text-encoding-test;
end suite;
