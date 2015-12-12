module: dylan-user

define module postgresql
  use dylan;

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

      <pg-connection>
    };

  export pg-connect,
         pg-connect-async,
         pg-connect-poll;

  export pg-connection-status;

  export pg-finish;

  export pg-reset,
         pg-reset-async,
         pg-reset-poll;

  export pg-ping;

  export pg-protocol-version,
         pg-server-version;

  export pg-socket;
end module postgresql;
