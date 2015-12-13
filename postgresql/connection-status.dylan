Module: postgresql
Synopsis: Bindings for the raw functions.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define inline function pg-connection-status
    (connection :: <pg-connection>)
 => (status :: <integer>)
  PQstatus(connection)
end function pg-connection-status;

define inline function pg-protocol-version
    (connection :: <pg-connection>)
 => (version :: <integer>)
  PQprotocolVersion(connection)
end function pg-protocol-version;

define inline function pg-server-version
    (connection :: <pg-connection>)
 => (version :: <integer>)
  PQserverVersion(connection)
end function pg-server-version;

define inline function pg-socket
    (connection :: <pg-connection>)
 => (file-descriptor :: <integer>)
  PQsocket(connection)
end function pg-socket;
