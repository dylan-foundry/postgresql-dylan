module: dylan-user

define library pq
  use common-dylan;
  use c-ffi;

  export pq;
end library;

define module pq
  use common-dylan;
  use c-ffi;

  export $pq-no-compression, $pq-snappy-compression;

  export pq-open, pq-close, pq-put, pq-delete,
    pq-write, pq-get;

  export pq-create-iterator, pq-create-snapshot,
    pq-release-snapshot;

  export pq-property-value, pq-approximate-sizes,
    pq-compact-range, pq-destroy-db, pq-repair-db,
    pq-iter-destroy, pq-iter-valid, pq-iter-seek-to-first,
    pq-iter-seek-to-last, pq-iter-seek, pq-iter-next,
    pq-iter-prev, pq-iter-key, pq-iter-value,
    pq-iter-get-error;

  export pq-writebatch-create, pq-writebatch-destroy,
    pq-writebatch-clear, pq-writebatch-put,
    pq-writebatch-delete, pq-writebatch-iterate;

  export pq-options-create, pq-options-destroy,
    pq-options-set-comparator, pq-options-set-filter-policy,
    pq-options-set-create-if-missing, pq-options-set-error-if-exists,
    pq-options-set-paranoid-checks, pq-options-set-env,
    pq-options-set-info-log, pq-options-set-write-buffer-size,
    pq-options-set-max-open-files, pq-options-set-cache,
    pq-options-set-block-size, pq-options-set-block-restart-interval,
    pq-options-set-compression;

  export pq-comparator-create, pq-comparator-destroy;

  export pq-filterpolicy-create, pq-filterpolicy-destroy,
    pq-filterpolicy-create-bloom;

  export pq-readoptions-create, pq-readoptions-destroy,
    pq-readoptions-set-verify-checksums,
    pq-readoptions-set-fill-cache,
    pq-readoptions-set-snapshot;

  export pq-writeoptions-create, pq-writeoptions-destroy,
    pq-writeoptions-set-sync;

  export pq-cache-create-lru, pq-cache-destroy;

  export pq-create-default-env, pq-env-destroy;
end module;
