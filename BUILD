load("//rule:gen_dir_rule.bzl", "gen_dir")
load("@rules_cc//cc:defs.bzl", "cc_library")

gen_dir(
    name = "gen-srcs-dir",
)

cc_library(
    name = "library",
    srcs = [
        ":gen-srcs-dir",
    ],
    linkstatic = 1,
    deps = [":gen-srcs-dir"],
)
