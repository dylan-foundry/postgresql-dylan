Module: postgresql
Synopsis: Bindings for the raw functions.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define inline function pg-result-status
    (result :: <pg-result>)
 => (status :: <integer>)
  PQresultStatus(result)
end function pg-result-status;

define inline function pg-result-status-as-text
    (result-status :: <integer>)
 => (text :: <string>)
  PQresStatus(result-status)
end function pg-result-status-as-text;

define inline function pg-result-error-message
    (result :: <pg-result>)
 => (error-message :: <string>)
  PQresultErrorMessage(result)
end function pg-result-error-message;

define inline function pg-result-command-status
    (result :: <pg-result>)
 => (status :: <string>)
  PQcmdStatus(result)
end function pg-result-command-status;

define inline function pg-result-clear
    (result :: <pg-result>)
 => ()
 PQclear(result)
end function pg-result-clear;

define inline function pg-result-num-tuples
    (result :: <pg-result>)
 => (num :: <integer>)
  PQntuples(result)
end function pg-result-num-tuples;

define inline function pg-result-num-fields
    (result :: <pg-result>)
 => (num :: <integer>)
  PQnfields(result)
end function pg-result-num-fields;

define inline function pg-result-field-name
    (result :: <pg-result>,
     field-number :: <integer>)
 => (field-name :: <string>)
  PQfname(result, field-number)
end function pg-result-field-name;

define inline function pg-result-field-number
    (result :: <pg-result>,
     field-name :: <string>)
 => (field-number :: <integer>)
  PQfnumber(result, field-name)
end function pg-result-field-number;

define inline function pg-result-field-table
    (result :: <pg-result>,
     field-number :: <integer>)
 => (table-oid :: <integer>)
  PQftable(result, field-number)
end function pg-result-field-table;

define inline function pg-result-field-table-column
    (result :: <pg-result>,
     field-number :: <integer>)
 => (column-number :: <integer>)
  PQftablecol(result, field-number)
end function pg-result-field-table-column;

define inline function pg-result-field-format
    (result :: <pg-result>,
     field-number :: <integer>)
 => (field-format :: <integer>)
  PQfformat(result, field-number)
end function pg-result-field-format;

define inline function pg-result-field-type
    (result :: <pg-result>,
     field-number :: <integer>)
 => (field-type-oid :: <integer>)
  PQftype(result, field-number)
end function pg-result-field-type;

define inline function pg-result-field-type-modifier
    (result :: <pg-result>,
     field-number :: <integer>)
 => (type-modifier :: <integer>)
  PQfmod(result, field-number)
end function pg-result-field-type-modifier;

define inline function pg-value
    (result :: <pg-result>,
     row-number :: <integer>,
     column-number :: <integer>)
 => (value :: <string>)
  PQgetvalue(result, row-number, column-number)
end function pg-value;

define inline function pg-value-null?
    (result :: <pg-result>,
     row-number :: <integer>,
     column-number :: <integer>)
 => (null? :: <boolean>)
  PQgetisnull(result, row-number, column-number)
end function pg-value-null?;

define inline function pg-value-byte-length
    (result :: <pg-result>,
     row-number :: <integer>,
     column-number :: <integer>)
 => (byte-length :: <integer>)
  PQgetlength(result, row-number, column-number)
end function pg-value-byte-length;
