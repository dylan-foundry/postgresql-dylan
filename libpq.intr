module: libpq

define interface
  #include "libpq-fe.h",
    equate: {"char *" => <c-string>},
    exclude: {
      "PQtrace",
      "PQuntrace",
      "PQprint",
      "PQdisplayTuples",
      "PQprintTuples"
    };
end interface;

