Module: postgresql
Synopsis: Bindings for the raw functions.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define inline function pg-execute
    (connection :: <pg-connection>,
     command :: <string>,
     #rest parameters)
 => (result :: <pg-result>)
  if (empty?(parameters))
    PQexec(connection, command)
  else
    let param-count = parameters.size;
    let param-types = null-pointer(<unsigned-int*>);
    let param-values = make(<statically-typed-pointer*>,
                            element-count: param-count);
    for (p in parameters, idx from 0)
      let encoded = pg-encode-as-text(p);
      param-values[idx] := byte-storage-address(encoded);
    end for;
    let param-lengths = null-pointer(<int*>);
    let param-formats = null-pointer(<int*>);
    PQexecParams(connection, command, param-count, param-types,
                 param-values, param-lengths, param-formats, 0)
  end if
end function pg-execute;
