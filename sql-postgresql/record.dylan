Module: sql-postgresql-implementation
Synopsis: PostgreSQL backend for database library.
Author: Edward Cessna and Bruce Mitchener, Jr.
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND


define concrete sealed class <postgresql-record> (<record>)
end class;

define concrete sealed class <postgresql-coercion-record> (<postgresql-record>,
                                                           <coercion-record>)
end class;

define method initialize(record :: <postgresql-record>, #key)
  => ()
  next-method();

/*
  let (return-code, column-count) = SQLNumResultCols(statement-handle);

  for (column-number :: <integer> from 1 to column-count)
    let binding = do-binding(column-number);
    record.bindings := add!(record.bindings, binding);
  end for;
*/
end method;


/*
define method acquire-binding(record :: <postgresql-record>, key :: <integer>)
 => (field :: <object>, null? :: <boolean>)
  let binding = element(record.bindings, key);
  values(binding, null-postgresql-field?(binding.data-length));
end method;
*/

define method next-record-state(record :: <postgresql-record>, state :: <integer>)
 => (next-state :: <integer>)
  state + 1;
end method;

define method no-more-record-elements?(record :: <postgresql-record>,
                                       state :: <integer>, limit :: <integer>)
 => (finished :: <boolean>)
  state = limit;
end method;

define method record-element-key-by-state(record :: <postgresql-record>,
                                          state :: <integer>)
 => (key :: <integer>)
  state;
end method;

define method record-element-by-state(record :: <postgresql-record>,
                                      state :: <integer>)
 => (record-element :: <object>)
/*
  let (binding, null?) = acquire-binding(record, state);
  if (null? = #t)
    acquire-null-value(record.indicator-policy, state);
  else
    binding.storage;
  end if;
*/
end method;

define method record-element-by-state(record :: <postgresql-coercion-record>,
                                      state :: <integer>)
 => (record-element :: <object>)
/*
  let (binding, null?) = acquire-binding(record, state);
  if (null? = #t)
    acquire-null-value(record.indicator-policy, state);
  else
    convert-value(record.record-coercion-policy, binding.storage, state);
  end if;
*/
end method;

define method record-element-by-state-setter
    (new-element :: <object>,
     record :: <postgresql-record>,
     state :: <integer>)
 => (new-element :: <object>)
  //not supported!
end method;

define method copy-record-state
    (record :: <postgresql-record>,
     state :: <integer>)
 => (new-state :: <integer>)
  state;
end method;


define method forward-iteration-protocol
    (record :: <postgresql-record>)
 => (initial-state :: <integer>,
      limit :: <integer>,
      next-state :: <function>,
      finished-state? :: <function>,
      current-key :: <function>,
      current-element :: <function>,
      current-element-setter :: <function>,
      copy-state :: <function>)
  let initial-state :: <integer> = 0;
  let limit :: <integer> = 0; // record.bindings.size;
  values(initial-state,
         limit,
         next-record-state,
         no-more-record-elements?,
         record-element-key-by-state,
         record-element-by-state,
         record-element-by-state-setter,
         copy-record-state);
end method;



define method element
    (record :: <postgresql-record>,
     key :: <integer>,
     #key default = unsupplied())
  => (record-element :: <object>)
  block ()
    record-element-by-state(record, key)
  exception (condition :: <data-not-available>)  //++ correct condition?
    if (unsupplied?(default))
      error("ELEMENT outside of range: %=", format-arguments: list(key));
    else
      default
    end if
  end block
end method;
