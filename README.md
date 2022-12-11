# bazel-gh-16987
Reproducer for bazel https://github.com/bazelbuild/bazel/issues/16987

Replace REMOTE_CACHE_URL="grpc://localhost:30001" with your remote cache address (it is needed to activate `--remote_download_minimal`)

Then run `./repro.sh`

And search for `Exec failed due to IOException: Input is a directory` in output log

```
Starting local Bazel server and connecting to it...
INFO: Starting clean.
Works for 6.0.0-pre.20221012.2
Starting local Bazel server and connecting to it...
release 6.0.0-pre.20221012.2
INFO: Invocation ID: 95bf4968-8baf-4cb8-a2b7-ba2d54e0fb5c
INFO: Analyzed target //:library (37 packages loaded, 161 targets configured).
INFO: Found 1 target...
Target //:library up-to-date:
  bazel-bin/liblibrary.a
INFO: Elapsed time: 7.154s, Critical Path: 0.24s
INFO: 6 processes: 3 internal, 3 darwin-sandbox.
INFO: Build completed successfully, 6 total actions
Fails on 6.0.0rc4 with --remote_download_minimal enabled
Starting local Bazel server and connecting to it...
release 6.0.0rc4
INFO: Invocation ID: 3bc6e199-062b-445e-9bdc-91edc750ee40
INFO: Analyzed target //:library (37 packages loaded, 161 targets configured).
INFO: Found 1 target...
ERROR: /Users/dpoluyanov/github.com/dpoluyanov/bazel-gh-16987/BUILD:8:11: Compiling gen-srcs-dir/gen_source.c failed: Exec failed due to IOException: Input is a directory: bazel-out/darwin_arm64-fastbuild/bin/gen-srcs-dir
Target //:library failed to build
Use --verbose_failures to see the command lines of failed build steps.
INFO: Elapsed time: 6.882s, Critical Path: 0.14s
INFO: 4 processes: 3 internal, 1 darwin-sandbox.
FAILED: Build did NOT complete successfully
INFO: Starting clean (this may take a while). Consider using --async if the clean takes more than several minutes.
Passes on 6.0.0rc4 without --remote_download_minimal disable
release 6.0.0rc4
INFO: Invocation ID: a6db4ae6-83b8-4365-a8a3-6094c34f6db3
INFO: Analyzed target //:library (37 packages loaded, 161 targets configured).
INFO: Found 1 target...
Target //:library up-to-date:
  bazel-bin/liblibrary.a
INFO: Elapsed time: 0.771s, Critical Path: 0.32s
INFO: 6 processes: 1 remote cache hit, 3 internal, 2 darwin-sandbox.
INFO: Build completed successfully, 6 total actions
INFO: Starting clean (this may take a while). Consider using --async if the clean takes more than several minutes.
```
