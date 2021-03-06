#!/bin/bash
# Copyright lowRISC contributors.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

# This will tar-up $toolchain_dest into a tar called $toolchain_full_name.tar.xz
#
# All files in that tarball will be in a directory called $toolchain_full_name,
# not $(basename $toolchain_dest).

set -e
set -x
set -o pipefail

if ! [ "$#" = 3 ]; then
  echo "Usage: $0 <toolchain_name> <toolchain_dest> <artifact_dir>"
  exit 2
fi;

# These arguments are provided by `./build-*-with-args.sh`
toolchain_full_name="$1"
toolchain_dest="$2"
artifact_dir="${3:-.}"

tar -cJ \
  --show-transformed-names --verbose \
  --directory="$(dirname "${toolchain_dest}")" \
  -f "${artifact_dir}/$toolchain_full_name.tar.xz" \
  --transform="flags=rhS;s@^$(basename "${toolchain_dest}")@$toolchain_full_name@" \
  --owner=0 --group=0 \
  "$(basename "${toolchain_dest}")"
