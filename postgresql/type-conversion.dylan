Module: postgresql
Synopsis: Bindings for the raw functions.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define constant <byte-sequence> = type-union(<byte-string>, <byte-vector>);

define generic pg-encode-as-text
    (value :: <object>)
 => (bytes :: <byte-sequence>);

define method pg-encode-as-text
    (value :: <byte-sequence>)
 => (bytes :: <byte-sequence>)
  value
end method pg-encode-as-text;

define method pg-encode-as-text
    (value :: <integer>)
 => (bytes :: <byte-sequence>)
  integer-to-string(value)
end method pg-encode-as-text;

define method pg-encode-as-text
    (value :: <boolean>)
 => (bytes :: <byte-sequence>)
  if (value)
    "t"
  else
    "f"
  end if
end method pg-encode-as-text;
