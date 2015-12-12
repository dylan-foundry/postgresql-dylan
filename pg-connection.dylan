Module: postgresql
Synopsis: Bindings for the raw functions.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define inline function pg-connect
    (connection-info :: <string>)
 => (connection :: <pg-connection>)
  PQconnectdb(connection-info)
end function pg-connect;

define inline function pg-connect-async
    (connection-info :: <string>)
 => (connection :: <pg-connection>)
  PQconnectStart(connection-info)
end function pg-connect-async;

define inline function pg-connect-poll
    (connection :: <pg-connection>)
 => (status :: <integer>)
  PQconnectPoll(connection)
end function pg-connect-poll;

define inline function pg-connection-status
    (connection :: <pg-connection>)
 => (status :: <integer>)
  PQstatus(connection)
end function pg-connection-status;

define inline function pg-finish
    (connection :: <pg-connection>)
 => ()
  PQfinish(connection);
end function pg-finish;

define inline function pg-reset
    (connection :: <pg-connection>)
 => ()
  PQreset(connection);
end function pg-reset;

define inline function pg-reset-async
    (connection :: <pg-connection>)
 => (status :: <integer>)
  PQresetStart(connection)
end function pg-reset-async;

define inline function pg-reset-poll
    (connection :: <pg-connection>)
 => (status :: <integer>)
  PQresetPoll(connection)
end function pg-reset-poll;

define inline function pg-ping
    (connection-info :: <string>)
 => (status :: <integer>)
  PQping(connection-info)
end function pg-ping;

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
