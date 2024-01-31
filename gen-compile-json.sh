#!/bin/env bash

(
	set -x
	rm ./compile_commands.json
	rm -rf ./bin
	make clean

	./configure.developer "$@" # 传递所有参数给 ./configure.developer
	bear -- make -j$(($(nproc) - 1))
)
