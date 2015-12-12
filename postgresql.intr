module: postgresql

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

