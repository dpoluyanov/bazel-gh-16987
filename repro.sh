#/bin/sh

bazelisk clean
REMOTE_CACHE_URL="grpc://localhost:30001"

export USE_BAZEL_VERSION=6.0.0-pre.20221012.2
echo "Works for 6.0.0-pre.20221012.2"
bazelisk info release
bazelisk build //:library --remote_upload_local_results=false --remote_cache=$REMOTE_CACHE_URL --remote_download_minimal

export USE_BAZEL_VERSION=6.0.0rc4
echo "Fails on 6.0.0rc4 with --remote_download_minimal enabled"
bazelisk info release
bazelisk build //:library --remote_upload_local_results=false --remote_cache=$REMOTE_CACHE_URL --remote_download_minimal || true
bazelisk clean

export USE_BAZEL_VERSION=6.0.0rc4
echo "Passes on 6.0.0rc4 without --remote_download_minimal disable"
bazelisk info release
bazelisk build //:library --remote_upload_local_results=false --remote_cache=$REMOTE_CACHE_URL
bazelisk clean