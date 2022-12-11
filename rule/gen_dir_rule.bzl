def gen_dir_impl(ctx):
    tool = ctx.executable._generator
    cc_sources_dir = ctx.actions.declare_directory(ctx.attr.name)

    outputs = [cc_sources_dir]
    cc_headers_dir = ctx.actions.declare_directory(ctx.attr.name + ".cc_headers")
    outputs.append(cc_headers_dir)

    compilation_context = cc_common.create_compilation_context(headers = depset([cc_headers_dir]), includes = depset([cc_headers_dir.path]))

    args = ctx.actions.args()
    args.add(cc_sources_dir.path)
    args.add(cc_headers_dir.path)

    ctx.actions.run(
        outputs = outputs,
        arguments = [args],
        executable = tool,
    )
    return [DefaultInfo(files = depset(outputs)), CcInfo(compilation_context = compilation_context)]

gen_dir = rule(
    implementation = gen_dir_impl,
    attrs = {
        "_generator": attr.label(
            allow_single_file = True,
            cfg = "exec",
            executable = True,
            default = ":gen-dir.sh",
        ),
    },
)
