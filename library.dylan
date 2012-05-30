module: dylan-user

define library libpq
  use common-dylan;
  use c-ffi;

  export libpq;
end library;

define module libpq
  use common-dylan;
  use c-ffi;

  export $libpq-no-compression, $libpq-snappy-compression;

  export libpq-open, libpq-close, libpq-put, libpq-delete,
    libpq-write, libpq-get;

  export libpq-create-iterator, libpq-create-snapshot,
    libpq-release-snapshot;

  export libpq-property-value, libpq-approximate-sizes,
    libpq-compact-range, libpq-destroy-db, libpq-repair-db,
    libpq-iter-destroy, libpq-iter-valid, libpq-iter-seek-to-first,
    libpq-iter-seek-to-last, libpq-iter-seek, libpq-iter-next,
    libpq-iter-prev, libpq-iter-key, libpq-iter-value,
    libpq-iter-get-error;

  export libpq-writebatch-create, libpq-writebatch-destroy,
    libpq-writebatch-clear, libpq-writebatch-put,
    libpq-writebatch-delete, libpq-writebatch-iterate;

  export libpq-options-create, libpq-options-destroy,
    libpq-options-set-comparator, libpq-options-set-filter-policy,
    libpq-options-set-create-if-missing, libpq-options-set-error-if-exists,
    libpq-options-set-paranoid-checks, libpq-options-set-env,
    libpq-options-set-info-log, libpq-options-set-write-buffer-size,
    libpq-options-set-max-open-files, libpq-options-set-cache,
    libpq-options-set-block-size, libpq-options-set-block-restart-interval,
    libpq-options-set-compression;

  export libpq-comparator-create, libpq-comparator-destroy;

  export libpq-filterpolicy-create, libpq-filterpolicy-destroy,
    libpq-filterpolicy-create-bloom;

  export libpq-readoptions-create, libpq-readoptions-destroy,
    libpq-readoptions-set-verify-checksums,
    libpq-readoptions-set-fill-cache,
    libpq-readoptions-set-snapshot;

  export libpq-writeoptions-create, libpq-writeoptions-destroy,
    libpq-writeoptions-set-sync;

  export libpq-cache-create-lru, libpq-cache-destroy;

  export libpq-create-default-env, libpq-env-destroy;
end module;
