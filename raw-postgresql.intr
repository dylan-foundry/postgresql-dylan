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
    };
end interface;

