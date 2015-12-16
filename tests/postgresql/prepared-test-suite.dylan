module: postgresql-test-suite
synopsis: Test suite for postgresql result handling.

define test prepared-query-test ()
  let conn = pg-connect("");

  let res = pg-prepare(conn, "test-prepared-query",
                       "SELECT $1::int4 AS FOO, 2 AS \"BAR\";",
                       <integer>);
  assert-equal($PGRES-COMMAND-OK, pg-result-status(res));

  let res = pg-execute-prepared(conn, "test-prepared-query", 1);
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

  let res = pg-describe-prepared(conn, "test-prepared-query");
  assert-equal($PGRES-COMMAND-OK, pg-result-status(res));
  assert-equal(0, pg-result-num-tuples(res));
  assert-equal(2, pg-result-num-fields(res));
  assert-equal("foo", pg-result-field-name(res, 0));
  assert-equal("BAR", pg-result-field-name(res, 1));
  assert-equal(0, pg-result-field-number(res, "foo"));
  assert-equal(0, pg-result-field-number(res, "FOO"));
  assert-equal(-1, pg-result-field-number(res, "BAR"));
  assert-equal(1, pg-result-field-number(res, "\"BAR\""));
  assert-no-errors(pg-result-clear(res));

  let res = pg-execute(conn, "DEALLOCATE PREPARE \"test-prepared-query\";");
  assert-equal($PGRES-COMMAND-OK, pg-result-status(res));
  assert-equal(0, pg-result-num-tuples(res));

  assert-no-errors(pg-finish(conn));
end test prepared-query-test;

define suite prepared-test-suite ()
  test prepared-query-test;
end suite;
