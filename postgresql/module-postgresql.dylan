module: dylan-user

define module postgresql
  use dylan;
  use common-dylan;
  use c-ffi;

  use %postgresql,
    export: {
      <ConnStatusType>,
      $CONNECTION-AUTH-OK,
      $CONNECTION-AWAITING-RESPONSE,
      $CONNECTION-BAD,
      $CONNECTION-MADE,
      $CONNECTION-NEEDED,
      $CONNECTION-OK,
      $CONNECTION-SETENV,
      $CONNECTION-SSL-STARTUP,
      $CONNECTION-STARTED,

      <PostgresPollingStatusType>,
      $PGRES-POLLING-FAILED,
      $PGRES-POLLING-READING,
      $PGRES-POLLING-WRITING,
      $PGRES-POLLING-OK,
      $PGRES-POLLING-ACTIVE,

      <PGPing>,
      $PQPING-OK,
      $PQPING-REJECT,
      $PQPING-NO-RESPONSE,
      $PQPING-NO-ATTEMPT,

      <ExecStatusType>,
      $PGRES-EMPTY-QUERY,
      $PGRES-COMMAND-OK,
      $PGRES-TUPLES-OK,
      $PGRES-COPY-OUT,
      $PGRES-COPY-IN,
      $PGRES-BAD-RESPONSE,
      $PGRES-NONFATAL-ERROR,
      $PGRES-FATAL-ERROR,
      $PGRES-COPY-BOTH,
      $PGRES-SINGLE-TUPLE,

      <pg-connection>,

      <pg-result>
    };

  export pg-connect,
         pg-connect-async,
         pg-connect-poll,
         $invalid-pg-connection;

  export pg-connection-status,
         pg-connection-error-message;

  export pg-finish;

  export pg-reset,
         pg-reset-async,
         pg-reset-poll;

  export pg-ping;

  export pg-protocol-version,
         pg-server-version;

  export pg-socket;

  export pg-encode-as-text;

  export pg-execute;

  export pg-prepare,
         pg-execute-prepared,
         pg-describe-prepared;

  export pg-result-status,
         pg-result-status-as-text,
         pg-result-error-message,
         pg-result-command-status,
         pg-result-clear,
         pg-result-num-tuples,
         pg-result-num-fields,
         pg-result-field-name,
         pg-result-field-number,
         pg-result-field-table,
         pg-result-field-table-column,
         pg-result-field-format,
         pg-result-field-type,
         pg-result-field-type-modifier,
         pg-value,
         pg-value-null?,
         pg-value-byte-length;
end module postgresql;
