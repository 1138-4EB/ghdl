#! /bin/sh

set -e

if [ -z $CC ]; then
  CC="gcc"
fi
if ! which $CC; then
  echo "VPI testsuite skipped without C compiler"
  exit 0
fi

$(dirname "$0")/../suite_driver.sh vpi $@
