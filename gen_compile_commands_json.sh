#!/bin/env bash

# Check if the "--reconfigure" flag is provided
reconfigure=false
if [[ "$@" == *"--reconfigure"* ]]; then
	reconfigure=true
	set -- "${@/--reconfigure/}"
fi

if [ "$reconfigure" = true ]; then

	if [ -d ".wafcache" ]; then
		(
			set -x
			make clean
		)
	fi

	(
		set -x
		rm -rf ./compile_commands.json
		rm -rf ./bin
	)

	(
		set -x
		./configure.developer "$@" # 传递除了 "--reconfigure" 以外的参数给 ./configure.developer
	)
fi

(
	set -x

	make -j$(($(nproc) - 1))
	cp ./bin/default/compile_commands.json ./compile_commands.json
	echo "please invoke 'make install' manually if you want to install the binaries."
)
