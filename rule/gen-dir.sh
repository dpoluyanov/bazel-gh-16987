#/bin/sh

sources_dir=$1
headers_dir=$2

cat <<EOF>> $sources_dir/gen_source.c

int lib_func() { return 1; }
EOF

cat <<EOF>> $headers_dir/gen_source.h
int lib_func();
EOF
