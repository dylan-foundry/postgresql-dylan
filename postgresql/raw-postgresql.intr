Module: %postgresql
Synopsis: Auto-generated bindings for the libpq API.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define interface
  #include "libpq-fe.h",
    exclude: {
      "PQtrace",
      "PQuntrace",
      "PQprint",
      "PQdisplayTuples",
      "PQprintTuples",
      "PQfn",
      "PQArgBlock"
    },
    inline-functions: inline;

  function "PQgetisnull",
    map-result: <C-boolean>;

  struct "struct pg_conn",
    pointer-type-name: <pg-connection>;
  struct "struct pg_result" => <_pg-result>,
    pointer-type-name: <pg-result>;
end interface;

