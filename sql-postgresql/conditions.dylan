Module: sql-postgresql-implementation
Synopsis: PostgreSQL backend for database library.
Author: Bruce Mitchener, Jr.
Copyright: See LICENSE file in this distribution.

define open abstract class <postgresql-error> (<database-error>)
end class <postgresql-error>;

define sealed class <postgresql-low-level-error> (<postgresql-error>)
  constant slot low-level-error-message :: <string>,
    required-init-keyword: message:;
end class <postgresql-low-level-error>;

define constant $postgresql-diagnostics-key = #"postgresql-dbms";

define method assert-postgresql-goodness
    (res :: <pg-result>,
     conn :: <pg-connection>)
 => ()
  local method look-deeper ()
          let condition-type = find-diagnostic($diagnostic-table,
                                               $postgresql-diagnostics-key,
                                               res);
          if (unfound?(condition-type))
            make(<postgresql-low-level-error>,
                 message: pg-result-error-message(res))
          else
            make(condition-type)
          end if
        end method;
  let status = pg-result-status(res);
  if (status ~= $PGRES-COMMAND-OK & status ~= $PGRES-TUPLES-OK)
    if (status = $PGRES-TUPLES-OK & pg-result-num-tuples(res) = 0)
      let condition = make(<data-not-available>);
      // Handle a *postgresql-report-<data-not-available>* here.
      signal(condition);
    else
      let condition = look-deeper();
      signal(condition);
    end if;
  end if;
end method assert-postgresql-goodness;

define inline method assert-postgresql-goodness
    (res :: <pg-result>,
     conn :: <postgresql-connection>)
 => ()
  assert-postgresql-goodness(res, conn.%connection-handle)
end method assert-postgresql-goodness;
