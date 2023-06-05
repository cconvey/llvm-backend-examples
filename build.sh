#!/bin/bash
set -o errexit
set -o nounset

declare save_dir="$(pwd)"
if [[ $# == 0 ]]; then
    declare src_dir="$(pwd)"
elif [[ $# == 1 ]]; then
    if ! [[ -d "${1}" ]]; then
        echo "Not a directory: ${1}" >&2
        exit 1
    fi
    declare src_dir="$(realpath ${1})"
else
    echo "Usage: ${0} [src-dir]" >&2
    exit 1
fi

pushd "${src_dir}"
rm -f *.s *.ll *.ii *.bc *.o

clang++ -c --save-temps -emit-llvm -O0 foo.cpp
llvm-dis foo.bc | c++filt > foo-demangled.ll
cat foo.s | c++filt > foo-demangled.s

clang++ -c -O0 foo.cpp
objdump -d foo.o | c++filt > foo-obj-demangled-disassembled.s

popd
